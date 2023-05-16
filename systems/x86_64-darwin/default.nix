let
  darwinSystem = (import ../../shared/constants.nix).systems.darwinSystem;
in {
  name = "x86darwin";
  system = darwinSystem;
  extraModules = {lib, ...}: [
    {
      nixpkgs.hostPlatform = lib.mkDefault darwinSystem;
    }
  ];
}
