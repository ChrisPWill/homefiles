{
  description = "Shared Home Manager configuration for MacOS and Linux";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      # Import shared constants
      shared = import ./shared/constants.nix;

      # Import machine configuration based on hostname
      machineConfig = hostname: import ./machines/${hostname}.nix;

      # Select the correct nixpkgs based on the system
      pkgsFor = system: import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      # Import 'lib' attribute from Nixpkgs
      lib = nixpkgs.lib;

      # System-specific values based on hostname
      systemValues = hostname: system: let
        pkgs = pkgsFor system;
      in import ./systems/${system}.nix { inherit pkgs lib; };

      # Define the Home Manager configuration for a specific system
      homeConfigFor = hostname: system: let
        values = systemValues hostname system;
        pkgs = pkgsFor system;
        commonPrograms = {
          neovim = import ./programs/neovim.nix;
          git = import ./programs/git.nix { inherit (shared) userFullName; userEmail = (machineConfig hostname).userEmail; };
          firefox = import ./programs/firefox.nix;
          vscode = import ./programs/vscode.nix;
        };
      in home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [{
          home = import ./shared/home.nix { inherit (shared) userName; inherit (values) homeDirPrefix; };

          # Merge common and system-specific programs
          programs = lib.mkForce (lib.mergeAttrs commonPrograms values.extraPrograms);

          # xsession
          xsession = {
            enable = true;
            windowManager = {
              awesome = {
                enable = true;
                luaModules = with pkgs.luaPackages; [
                  luarocks
                ];
              };
            };
          };
        }];
      };

    in {
      homeConfigurations = {
        "${shared.userName}@${shared.hostnames.workMbp}" = homeConfigFor shared.hostnames.workMbp shared.darwinSystem;
        "${shared.userName}@${shared.hostnames.personalPc}" = homeConfigFor shared.hostnames.personalPc shared.linuxSystem;
      };
    };
}
