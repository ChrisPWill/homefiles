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

      # Import machine configuration
      machineConfig = import ./machines/personal-pc.nix;

      # Select the correct nixpkgs based on the system
      pkgsFor = system: nixpkgs.legacyPackages.${system};

      # Import 'lib' attribute from Nixpkgs
      lib = nixpkgs.lib;

      # System-specific values
      systemValues = system: let pkgs = pkgsFor system; in import ./systems/nixos.nix { inherit pkgs lib; };

      # Define the Home Manager configuration for a specific system
      homeConfigFor = system: let
        values = systemValues system;
        pkgs = pkgsFor system;
        commonPrograms = {
          neovim = import ./programs/neovim.nix;
          git = import ./programs/git.nix { inherit (shared) userFullName; userEmail = machineConfig.userEmail; };
	  firefox = import ./programs/firefox.nix;
	  ripgrep = import ./programs/ripgrep.nix;
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

      # Darwin configurations
      darwinConfigurations = {
        ${shared.userName} = homeConfigFor shared.darwinSystem;
      };
      nixosConfigurations = {
        ${shared.userName} = homeConfigFor shared.linuxSystem;
      };

    in {
      homeConfigurations = nixosConfigurations;
    };
}
