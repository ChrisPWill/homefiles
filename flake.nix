{
  description = "ChrisPWill Nix flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    darwin.url = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    darwin,
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
  }: let
    hostConfigs = import ./hosts;
    systemConfigs = import ./systems;
    userConfigs = import ./shared/users.nix;
    theme = import ./shared/theme.nix;
    inherits = {
      inherit (nixpkgs) lib;
      inherit inputs nixpkgs nixpkgs-unstable home-manager theme;
      inherit hostConfigs systemConfigs;
    };
  in {
    nixosConfigurations = import ./nixos (inherits
      // {
        user = userConfigs.cwilliams;
      });

    darwinConfigurations = import ./darwin (inherits
      // {
        inherit darwin;
        user = userConfigs.cwilliams;
      });

    homeConfigurations = import ./home-manager (inherits
      // {
        user = userConfigs.cwilliams;
      });
  };
}
