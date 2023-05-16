let
  linuxSystem = (import ../../shared/constants.nix).systems.linuxSystem;
in {
  name = "x64linux";
  system = linuxSystem;
  extraModules = {lib, ...}: [
    {
      services.xserver = {
        enable = true;
        displayManager = {
          defaultSession = "none+awesome";
          lightdm.enable = true;
        };

        windowManager.awesome = {
          enable = true;
        };
      };
      nixpkgs.hostPlatform = lib.mkDefault linuxSystem;
    }
  ];
}
