{
  description = "A flake for my personal configuration with home-manager on MacOS and NixOS";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    home-manager.url = "github:nix-community/home-manager";
  };

  outputs = { self, nixpkgs, nix-darwin, home-manager }:
    let
      darwinSystem = "x86_64-darwin";
      nixosSystem = "x86_64-linux";

      commonConfig = {
        allowUnfree = true;
        allowBroken = true;
      };

      pkgsDarwin = nixpkgs.legacyPackages.${darwinSystem}.extend nix-darwin.overlay;
      pkgsNixOS = nixpkgs.legacyPackages.${nixosSystem};

      darwinConfig = { pkgs, ... }: {
        nix.darwinConfig = {
          overlays = [ nix-darwin.overlay ];
          system.stateVersion = 4;
          system.activationScripts = { };
          environment.systemPackages = with pkgs; [ ];
        };
      };

      home-manager-config = { system, pkgs, ... }: {
        imports = [
          "${home-manager}/modules/home-manager/home-manager.nix"
        ];

        home-manager.users.cwilliams = { config, pkgs, ... }: {
          home.packages = with pkgs; [
          ];

          home.stateVersion = "22.11";
        };
      };

    in {
      nix-darwin = nix-darwin.lib.darwinSystem {
        modules = [
          darwinConfig
          (home-manager-config { system = darwinSystem; pkgs = pkgsDarwin; })
        ];
        system = darwinSystem;
      };

      nixosConfigurations.ChrisPC = nixpkgs.lib.nixosSystem {
        modules = [
          {
            imports = [
              (home-manager-config { system = nixosSystem; pkgs = pkgsNixOS; })
            ];

            # Please set your desired hostname
            networking.hostName = "ChrisPC";
          }
        ];
        system = nixosSystem;
      };


      home-manager = home-manager.lib.homeManagerConfiguration {
        configuration = { pkgs, ... }: {
          imports = [
            (home-manager-config { system = darwinSystem; pkgs = pkgsDarwin; })
          ];
        };
        system = darwinSystem;
        username = "cwilliams";
      };
    };
}