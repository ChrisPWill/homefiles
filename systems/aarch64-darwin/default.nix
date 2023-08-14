let
  darwinArmSystem = (import ../../shared/constants.nix).systems.darwinArmSystem;
in {
  name = "aarch64darwin";
  system = darwinArmSystem;
  extraModules = {lib, ...}: [
    {
      nixpkgs.hostPlatform = lib.mkDefault darwinArmSystem;
    }
  ];
}
