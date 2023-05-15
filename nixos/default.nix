{
  lib,
  nixpkgs,
  hostConfigs,
  systemConfigs,
  ...
}: let
  mkNixosConfig = {
    hostConfig,
    systemConfig,
  }:
    nixpkgs.lib.nixosSystem {
      system = systemConfig.system;
      modules =
        [
          ./configuration.nix
        ]
        ++ systemConfig.extraModules
        ++ hostConfig.extraModules;
    };
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
