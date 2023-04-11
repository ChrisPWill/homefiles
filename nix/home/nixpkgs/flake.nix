{
  description = "Shared Home Manager configuration for MacOS";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
  };

  outputs = { self, nixpkgs, home-manager }:
    let
      # Constants
      darwinSystem = "x86_64-darwin";
      userName = "cwilliams";

      # Select the correct nixpkgs based on the system
      pkgsFor = system: nixpkgs.legacyPackages.${system};

      # Import 'lib' attribute from Nixpkgs
      lib = nixpkgs.lib;

      # System-specific values
      systemValues = system: {
        x86_64-darwin = {
          homeDirPrefix = "/Users";
          extraPrograms = { kitty = { enable = true; }; };
        };
      }.${system};

      # Define the Home Manager configuration for a specific system
      homeConfigFor = system: let
        values = systemValues system;
        commonPrograms = {
          vim = { enable = true; };
          git = { enable = true; };
        };
      in {
        home = {
          username = userName;
          homeDirectory = "${values.homeDirPrefix}/${userName}";
          stateVersion = "23.05";
        };

        programs = lib.mkForce (lib.mergeAttrs commonPrograms values.extraPrograms);
      };

      darwinConfigurations = {
        ${userName} = home-manager.lib.homeManagerConfiguration {
          pkgs = pkgsFor darwinSystem;
          modules = [
            homeConfigFor darwinSystem
          ];
        };
      };

    in {
      homeConfigurations = darwinConfigurations;
    };
}