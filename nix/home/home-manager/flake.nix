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
      hostConfig = hostname: import ./hosts/${hostname}.nix;

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
        systemConfig = systemValues hostname system;
        pkgs = pkgsFor system;
        commonPrograms = {
          bat = import ./programs/bat.nix;
          exa = import ./programs/exa.nix;
          fzf = import ./programs/fzf.nix;
          git = import ./programs/git.nix { inherit (shared) userFullName; userEmail = (hostConfig hostname).userEmail; };
          neovim = import ./programs/neovim.nix { inherit pkgs; };
          vscode = import ./programs/vscode.nix;
          zsh = import ./programs/zsh.nix;
        };
      in home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          {
            fonts.fontconfig.enable = true;

            home = import ./shared/home.nix { inherit (shared) userName; inherit (systemConfig) homeDirPrefix; inherit pkgs; };

            # Merge common and system-specific programs
            programs = lib.mkForce (lib.mergeAttrs commonPrograms systemConfig.extraPrograms);
          }
        ] ++ systemConfig.extraModules ++ (hostConfig hostname).extraModules; # Include extra modules from system and machine files
      };

    in {
      homeConfigurations = {
        "${shared.userName}@${shared.hostnames.workMbp}" = homeConfigFor shared.hostnames.workMbp shared.darwinSystem;
        "${shared.userName}@${shared.hostnames.personalPc}" = homeConfigFor shared.hostnames.personalPc shared.linuxSystem;
      };
    };
}
