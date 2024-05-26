{
  pkgs,
  pkgs-unstable,
  lib,
  sharedEnabledLanguages,
  theme,
  ...
}: let
  hostEnabledLanguages = [
    "rust"
    "javascript"
    "typescript"
    "html"
    "graphql"
    "yaml"
  ];
  enabledLanguages = sharedEnabledLanguages ++ hostEnabledLanguages;
in {
  userName = "cwilliams";
  userFullName = "Chris Williams";
  userEmail = "chris@chrispwill.com";
  extraModules = [
    {
      xdg.mimeApps = {
        enable = true;
        defaultApplications = {
          "image/jpeg" = "feh";
          "image/png" = "feh";
        };
      };
    }
    {
      home.file = {
        ".config/libvert/qemu.conf" = {
          source = ../programs/qemu/qemu.conf;
        };
      };
    }
  ];
  inherit enabledLanguages;
  extraPrograms = {
    helix = import ../programs/helix.nix {
      pkgs = pkgs-unstable;
    };
    neovim = import ../programs/neovim/neovim.nix {
      inherit pkgs;
      inherit pkgs-unstable;
      inherit lib;
      inherit enabledLanguages;
      inherit theme;
      enableCopilot = true;
    };
  };
  extraPackages = with pkgs; [
    discord
    qbittorrent
    pkgs-unstable.rust-analyzer
    pkgs-unstable.nodePackages.dockerfile-language-server-nodejs
    pkgs-unstable.nodePackages.typescript
    pkgs-unstable.nodePackages.typescript-language-server
    pkgs-unstable.nodePackages.yaml-language-server
  ];
  windowManager = "hyprland";
}
