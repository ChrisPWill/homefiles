{
  description = "Shared Home Manager configuration for MacOS and NixOS";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
  };

  outputs = { self, nixpkgs, home-manager }:
    let
      # Select the correct nixpkgs based on the system
      pkgsFor = system: import nixpkgs { inherit system; overlays = [ home-manager.overlay ]; };

      # Import 'lib' attribute from Nixpkgs
      lib = nixpkgs.lib;

      # System-specific values
      systemValues = {
        "x86_64-darwin" = {
          homeDirPrefix = "/Users";
          extraPrograms = { kitty = { enable = true; }; };
        };
        "x86_64-linux" = {
          homeDirPrefix = "/home";
          extraPrograms = { alacritty = { enable = true; }; };
        };
      };

      # Define the Home Manager configuration for a specific system
      homeConfigFor = system: let
        values = systemValues.${system};
        commonPrograms = {
          vim = { enable = true; };
          git = { enable = true; };
        };
      in {
        imports = [ (pkgsFor system).home-manager.lib.hmModulesPath ];

        home = {
          username = "cwilliams";
          homeDirectory = "${values.homeDirPrefix}/cwilliams";
          stateVersion = "23.05";
        };

        programs = lib.mkForce (lib.mergeAttrs commonPrograms values.extraPrograms);
      };
    in {
      # Home Manager configurations for MacOS and NixOS
      darwinConfigurations = {
        atlassian-mbp = homeConfigFor "x86_64-darwin";
      };
      nixosConfigurations = {
        personal-nixos-desktop = homeConfigFor "x86_64-linux";
      };

      # Basic checks for Flake
      checks = {
        darwin = nixpkgs.lib.tests.runTests nixpkgs darwinConfigurations.atlassian-mbp.config;
        nixos = nixpkgs.lib.tests.runTests nixpkgs nixosConfigurations.personal-nixos-desktop.config;
      };
    };
}