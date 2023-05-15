let
  darwinSystem = (import ../../shared/constants.nix).systems.darwinSystem;
in {
  system = darwinSystem;
  extraModules = {lib, ...}: [
    {
      nixpkgs.hostPlatform = lib.mkDefault darwinSystem;
    }
  ];
}
