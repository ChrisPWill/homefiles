{
  description = "ChrisPWill Nix flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
  }: let
    hostConfigs = import ./hosts;
    systemConfigs = import ./systems;

    inherits = {
      inherit (nixpkgs) lib;
      inherit inputs nixpkgs;
      inherit hostConfigs systemConfigs;
    };
  in {
    nixosConfigurations = import ./nixos inherits;
  };
}
