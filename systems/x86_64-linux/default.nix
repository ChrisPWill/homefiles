let
  linuxSystem = (import ../../shared/constants.nix).systems.linuxSystem;
in {
  name = "x64linux";
  system = linuxSystem;
  extraModules = {
    inputs,
    pkgs,
    lib,
    theme,
    user,
    ...
  }: [
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
    {
      environment.systemPackages = with pkgs; [
        gperftools
      ];
    }
    inputs.hyprland.nixosModules.default
    ./hyprland
  ];
}
