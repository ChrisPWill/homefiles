let
  host = "cwilliams-work-laptop";
  darwinArmSystem = "aarch64-darwin";
  stateVersion = "22.11";
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

      users.users.cwilliams = utils.userToDarwinUser sharedUsers.cwilliams pkgs;

      system.stateVersion =
        if systemConfig.system == darwinArmSystem
        then 4
        else stateVersion;

      programs.zsh.enable = true;

      homebrew = {
        enable = true;
        casks = [
          "loom"
        ];
      };
    }
  ];
}
