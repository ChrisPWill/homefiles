{
  description = "ChrisPWill Nix flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = inputs @ {
    self,
    hyprland,
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

    homeConfigurations = import ./home-manager (inherits
      // {
        user = userConfigs.cwilliams;
      });
  };
}
