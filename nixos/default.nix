{
  lib,
  nixpkgs,
  getHostConfigs,
  systemConfigs,
  ...
}: let
  getPkgs = system:
    import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
      };
      overlays = [];
    };
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
  hostAndSystemConfigs = lib.concatMap (systemConfig:
    map (hostConfig: {
      inherit hostConfig;
      inherit systemConfig;
    })
    (getHostConfigs {pkgs = getPkgs systemConfig.system;}))
  systemConfigs;
in
  builtins.listToAttrs (map (nixosInput @ {
      hostConfig,
      systemConfig,
      ...
    }: {
      name = hostConfig.hostName + ":" + systemConfig.system;
      value = mkNixosConfig nixosInput;
    })
    hostAndSystemConfigs)
