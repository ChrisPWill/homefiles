{
  system = "x86_64-linux";
  extraModules = [
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
    }
  ];
}
