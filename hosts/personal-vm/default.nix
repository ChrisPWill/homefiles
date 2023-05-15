let
  hostname = "personal-vm";
in {
  inherit hostname;
  stateVersion = "22.11";
  extraOverlays = [];
  extraModules = [
    {
      networking.hostName = hostname;
    }
  ];
}
