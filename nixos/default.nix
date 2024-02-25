{
  inputs,
  lib,
  nixpkgs,
  hostConfigs,
  systemConfigs,
  user,
  theme,
  ...
}: let
  sharedUtils = import ../shared/utils.nix;
  mkNixosConfig = {
    hostConfig,
    systemConfig,
  }: let
    pkgs = sharedUtils.getPkgs {
      inherit nixpkgs systemConfig;
    };
    system = systemConfig.system;
    extraModuleInherits = {inherit inputs pkgs lib systemConfig user theme;};
  in
    nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {inherit inputs;};
      modules =
        [
          ({pkgs, ... }: {
	    nixpkgs.config = lib.mkMerge [
	      systemConfig.extraNixpkgsConfig
	      hostConfig.extraNixpkgsConfig
	    ];
	  })
          ./configuration.nix
        ]
        ++ systemConfig.extraModules extraModuleInherits
        ++ hostConfig.extraModules extraModuleInherits;
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
      name = "${hostConfig.host}-${systemConfig.name}";
      value = mkNixosConfig nixosInput;
    })
    hostAndSystemConfigs)
