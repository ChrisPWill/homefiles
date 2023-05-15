{
  lib,
  hostConfigs,
  systemConfigs,
  ...
}: let
  mkNixosConfig = {
    hostConfig,
    systemConfig,
  }: {};
  hostAndSystemConfigs = lib.concatMap (systemConfig: map (hostConfig: hostConfig // systemConfig) hostConfigs) systemConfigs;
in
  builtins.listToAttrs (map (nixosInput @ {
      hostConfig,
      systemConfig,
      ...
    }: {
      name = hostConfig.hostName + ";" + systemConfig.system;
      value = mkNixosConfig nixosInput;
    })
    hostAndSystemConfigs)
