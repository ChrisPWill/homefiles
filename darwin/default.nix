{
  inputs,
  lib,
  nixpkgs,
  hostConfigs,
  systemConfigs,
  darwin,
  user,
  theme,
  ...
}: let
  sharedUtils = import ../shared/utils.nix;
  mkDarwinConfig = {
    hostConfig,
    systemConfig,
  }: let
    pkgs = sharedUtils.getPkgs {
      inherit nixpkgs systemConfig;
    };
    system = systemConfig.system;
    extraModuleInherits = {inherit inputs pkgs lib systemConfig user theme;};
  in
    darwin.lib.darwinSystem {
      inherit system;
      modules =
        [
          ./shared-configuration.nix
        ]
        ++ systemConfig.extraModules extraModuleInherits
        ++ hostConfig.extraModules extraModuleInherits
      ;
    };
  hostAndSystemConfigs = lib.concatMap (systemConfig:
    map (hostConfig: {
      inherit hostConfig;
      inherit systemConfig;
    })
    hostConfigs)
  systemConfigs;
in
  builtins.listToAttrs (map (darwinInput @ {
      hostConfig,
      systemConfig,
      ...
    }: {
      name = "${hostConfig.host}-${systemConfig.name}";
      value = mkDarwinConfig darwinInput;
    })
    hostAndSystemConfigs)
