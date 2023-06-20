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
  ];
  inherit enabledLanguages;
  extraPrograms = {
    neovim = import ../programs/neovim/neovim.nix {
      inherit pkgs;
      inherit pkgs-unstable;
      inherit lib;
      inherit enabledLanguages;
      inherit theme;
    };
  };
  extraPackages = with pkgs; [
    discord
    qbittorrent
    rust-analyzer
    nodePackages.dockerfile-language-server-nodejs
    nodePackages.typescript
    nodePackages.typescript-language-server
  ];
  windowManager = "hyprland";
}
