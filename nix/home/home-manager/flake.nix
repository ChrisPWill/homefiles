{
  description = "Shared Home Manager configuration for MacOS";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
  };

  outputs = { self, nixpkgs, home-manager }:
    let
      # Import shared constants
      shared = import ./shared/constants.nix;

      # Select the correct nixpkgs based on the system
      pkgsFor = system: nixpkgs.legacyPackages.${system};

      # Import 'lib' attribute from Nixpkgs
      lib = nixpkgs.lib;

      # System-specific values
      systemValues = system: let pkgs = pkgsFor system; in import ./systems/darwin.nix { inherit pkgs lib; };

      # Define the Home Manager configuration for a specific system
      homeConfigFor = system: let
        values = systemValues system;
        pkgs = pkgsFor system;
        commonPrograms = {
          neovim = import ./programs/neovim.nix;
          git = import ./programs/git.nix { inherit (shared) userFullName userEmail; };
        };
      in home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [{
          home = {
            username = shared.userName;
            homeDirectory = "${values.homeDirPrefix}/${shared.userName}";
            stateVersion = "23.05";
          };

          # Merge common and system-specific programs
          programs = lib.mkForce (lib.mergeAttrs commonPrograms values.extraPrograms);
        }];
      };

      # Darwin configurations
      darwinConfigurations = {
        ${shared.userName} = homeConfigFor shared.darwinSystem;
      };

    in {
      homeConfigurations = darwinConfigurations;
    };
}