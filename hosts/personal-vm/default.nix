let
  host = (import ../../shared/constants.nix).hosts.personalVm;
  stateVersion = "23.05";
  utils = import ../utils.nix;
  sharedUsers = import ../../shared/users.nix;
in {
  inherit host;
  inherit stateVersion;
  extraOverlays = [];
  extraModules = {
    pkgs,
    systemConfig,
    ...
  }: [
    {
      networking.hostName = "${host}-${systemConfig.name}";

      users.users.cwilliams = utils.userToNixosUser sharedUsers.cwilliams pkgs;

      system.stateVersion = stateVersion;

      programs.zsh.enable = true;
    }
    ./hardware-configuration.nix
  ];
}
