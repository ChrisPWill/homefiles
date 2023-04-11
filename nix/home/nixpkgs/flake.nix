{
  description = "Shared Home Manager configuration for MacOS and NixOS";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
  };

  outputs = { self, nixpkgs, home-manager }:
    let
      # System name constants
      darwinSystem = "x86_64-darwin";
      linuxSystem = "x86_64-linux";

      # Select the correct nixpkgs based on the system
      pkgsFor = system: import nixpkgs { inherit system; overlays = home-manager.overlays; };

      # Import 'lib' attribute from Nixpkgs
      lib = nixpkgs.lib;

      # System-specific values
      systemValues = {
        ${darwinSystem} = {
          homeDirPrefix = "/Users";
          extraPrograms = { kitty = { enable = true; }; };
        };
        ${linuxSystem} = {
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

      darwinConfigurations = {
        atlassian-mbp = homeConfigFor darwinSystem;
      };

      nixosConfigurations = {
        personal-nixos-desktop = homeConfigFor linuxSystem;
      };

    in {
      # Basic checks for Flake
      checks = {
        "${darwinSystem}-userEnv" = (pkgsFor darwinSystem).home-manager.buildUser home-manager.darwinConfigurations.atlassian-mbp.config;
        "${linuxSystem}-userEnv" = (pkgsFor linuxSystem).home-manager.buildUser home-manager.nixosConfigurations.personal-nixos-desktop.config;
      };
    };
}