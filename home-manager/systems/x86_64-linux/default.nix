{
  inputs,
  pkgs,
  lib,
  theme,
  ...
}: {
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

    firefox = import ../programs/firefox.nix;
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
        xdg.configFile."eww/scripts".source = ../programs/eww/scripts;
        xdg.configFile."eww/eww.scss".text = import ../programs/eww/eww.scss.nix {inherit theme;};
        xdg.configFile."eww/eww.yuck".text = import ../programs/eww/eww.yuck.nix {};
      }
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
    ++ (import ./x86_64-linux/hyprland);
}
