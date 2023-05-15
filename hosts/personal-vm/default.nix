let
  hostname = "personal-vm";
  stateVersion = "22.11";
  utils = import ../utils.nix;
  sharedUsers = import ../../shared/users.nix;
in {
  inherit hostname;
  inherit stateVersion;
  extraOverlays = [];
  extraModules = [
    {
      networking.hostName = hostname;

      users.users.cwilliams = utils.userToNixosUser sharedUsers.cwilliams;

      system.stateVersion = stateVersion;
    }
    ./hardware-configuration
  ];
}
