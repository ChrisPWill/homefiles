{
  lib,
  nixpkgs,
  home-manager,
  hostConfigs,
  systemConfigs,
  user,
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
  mkHomeConfig = {
    hostConfig,
    systemConfig,
  }: let
    pkgs = getPkgs systemConfig.system;
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
