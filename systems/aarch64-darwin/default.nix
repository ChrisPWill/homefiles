let
  darwinArmSystem = (import ../../shared/constants.nix).systems.darwinArmSystem;
in {
  name = "aarch64darwin";
  system = darwinArmSystem;
  extraModules = {pkgs, lib, ...}: [
    {
      nixpkgs.hostPlatform = lib.mkDefault darwinArmSystem;
      environment.systemPackages = with pkgs; [
        home-manager
      ];
    }
  ];
}
