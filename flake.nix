{
  description = "ChrisPWill Nix flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
  }: let
    hostConfigs = import ./hosts;
    systemConfigs = import ./systems;
    # userConfigs = import ./shared/users.nix;
    inherits = {
      inherit (nixpkgs) lib;
      inherit inputs nixpkgs home-manager;
      inherit hostConfigs systemConfigs;
    };
  in {
    nixosConfigurations = (import ./nixos) inherits;

    # homeConfigurations = import ./home-manager (inherits
    #   // {
    #     user = userConfigs.cwilliams;
    #   });
  };
}
