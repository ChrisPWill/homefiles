let
  hostName = (import ../../shared/constants.nix).hosts.personalVm;
  stateVersion = "22.11";
  utils = import ../utils.nix;
  sharedUsers = import ../../shared/users.nix;
in {
  inherit hostName;
  inherit stateVersion;
  extraOverlays = [];
  extraModules = {
    pkgs,
    system,
    ...
  }: [
    {
      networking.hostName = "${hostName}_${system}";

      users.users.cwilliams = utils.userToNixosUser sharedUsers.cwilliams pkgs;

      system.stateVersion = stateVersion;

      programs.zsh.enable = true;
    }
    ./hardware-configuration.nix
  ];
}
