{
  inputs,
  lib,
  nixpkgs,
  nixpkgs-unstable,
  home-manager,
  theme,
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
    pkgs-unstable = sharedUtils.getPkgs {
      nixpkgs = nixpkgs-unstable;
      inherit systemConfig;
    };

    # Temporary for porting from existing config
    # - will wrap some of this into new config files
    sharedHomeConfig = import ./shared/shared-config.nix;
    homeHostConfig = import ./hosts/${hostConfig.host}.nix {
      inherit pkgs;
      inherit pkgs-unstable;
      inherit lib;
      sharedEnabledLanguages = sharedHomeConfig.enabledLanguages;
      inherit theme;
    };
    homeSystemConfig = import ./systems/${systemConfig.system} {
      inherit inputs pkgs pkgs-unstable lib theme;
      programsPath = ./programs;
      windowManager = homeHostConfig.windowManager;
    };

    combinedEnabledLanguages = lib.unique (sharedHomeConfig.enabledLanguages ++ homeHostConfig.enabledLanguages or []);
    commonPrograms = import ./programs/common-programs.nix {
      system = systemConfig.system;
      inherit lib;
      inherit pkgs;
      inherit pkgs-unstable;
      enabledLanguages = combinedEnabledLanguages;
      userFullName = homeHostConfig.userFullName;
      userEmail = homeHostConfig.userEmail;
      inherit theme;
    };
  in
    home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules =
        [
          {
            home = import ./shared/home/settings.nix {
              userName = homeHostConfig.userName;
              inherit (homeSystemConfig) homeDirPrefix;
              inherit pkgs pkgs-unstable;
              extraPackages = homeSystemConfig.extraPackages ++ homeHostConfig.extraPackages;
            };
          }
          {
            # Font configuration
            fonts.fontconfig.enable = true;

            # Extra config files
            home.file = {
              # ".config/awesome/rc.lua".source = ./programs/awesome/rc.lua;
              # ".config/awesome/themes/theme.lua".text = import ./programs/awesome/themes/theme.nix {inherit theme;};
            };

            # Merge common and system-specific programs
            programs = lib.mkForce (lib.mergeAttrs commonPrograms (lib.mergeAttrs homeSystemConfig.extraPrograms homeHostConfig.extraPrograms));
          }
          # Neovim treesitter fix
          {
            xdg.configFile."nvim/parser".source = "${pkgs.symlinkJoin {
              name = "treesitter-parsers";
              paths = (pkgs.vimPlugins.nvim-treesitter.withAllGrammars).dependencies;
            }}/parser";
          }
        ]
        ++ homeSystemConfig.extraModules
        ++ homeHostConfig.extraModules; # Include extra modules from system and machine files
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
      name = "${user.userName}@${hostConfig.host}-${systemConfig.name}";
      value = mkHomeConfig homeInput;
    })
    hostAndSystemConfigs)
