{
  inputs,
  pkgs,
  lib,
  theme,
  programsPath,
  displayServerType,
  windowManager,
  ...
}: let
  wmModules = import (./window-managers + "/${windowManager}");
in {
  homeDirPrefix = "/home";
  extraPrograms = {
    wofi.enable = true;
    bash.enable = true;

    urxvt = {
      enable = true;
      fonts = ["xft:FantasqueSansMono Nerd Font Mono:size=10"];
      scroll = {
        bar.enable = false;
        keepPosition = true;
        lines = 10000;
        scrollOnKeystroke = true;
        scrollOnOutput = false;
      };
    };

    firefox = import (programsPath + "/firefox.nix");
  };

  extraPackages = with pkgs; [
    eww-wayland
    gnome.nautilus
    gnome.sushi
    swaybg
  ];

  extraModules =
    [
      {
        xsession = {
          enable = true;
          windowManager = {
            awesome = {
              enable = true;
              luaModules = with pkgs.luaPackages; [
                luarocks
              ];
            };
          };
        };

        xresources.extraConfig = import ./xresources.nix {inherit theme;};
      }
    ]
    ++ wmModules;
}
