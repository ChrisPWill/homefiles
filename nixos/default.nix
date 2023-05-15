{
  lib,
  nixpkgs,
  hostConfigs,
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
  }: let
    pkgs = getPkgs systemConfig.system;
    system = systemConfig.system;
  in
    nixpkgs.lib.nixosSystem {
      inherit pkgs;
      system = systemConfig.system;
      modules =
        [
          ./configuration.nix
        ]
        ++ systemConfig.extraModules {inherit pkgs system;}
        ++ hostConfig.extraModules;
    };
  hostAndSystemConfigs = lib.concatMap (systemConfig:
    map (hostConfig: {
      inherit hostConfig;
      inherit systemConfig;
    })
    hostConfigs)
  systemConfigs;
in
  builtins.listToAttrs (map (nixosInput @ {
      hostConfig,
      systemConfig,
      ...
    }: {
      name = "${hostConfig.hostName}:${systemConfig.system}";
      value = mkNixosConfig nixosInput;
    })
    hostAndSystemConfigs)
