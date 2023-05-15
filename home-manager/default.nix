{
  lib,
  nixpkgs,
  home-manager,
  hostConfigs,
  systemConfigs,
  user,
  ...
}: let
  sharedUtils = import ../shared/utils.nix;
  mkHomeConfig = {
    hostConfig,
    systemConfig,
  }: let
    pkgs = sharedUtils.getPkgs {inherit nixpkgs systemConfig;};

    # Shared constants
    theme = import ./theme.nix;
  in
    home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
    };
  hostAndSystemConfigs = lib.concatMap (systemConfig:
    map (hostConfig: {
      inherit hostConfig;
      inherit systemConfig;
    })
    hostConfigs)
  systemConfigs;
in
  builtins.listToAttrs (map (homeInput @ {
      hostConfig,
      systemConfig,
      ...
    }: {
      name = "${user.userName}@${hostConfig.hostName}_${systemConfig.system}";
      value = mkHomeConfig homeInput;
    })
    hostAndSystemConfigs)
