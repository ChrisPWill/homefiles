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
  ];

  extraModules = [
    {
      xdg.configFile."eww/scripts".source = ../programs/eww/scripts;
      xdg.configFile."eww/eww.scss".text = import ../programs/eww/eww.scss.nix {inherit theme;};
      xdg.configFile."eww/eww.yuck".text = import ../programs/eww/eww.yuck.nix {};
    }
    inputs.hyprland.homeManagerModules.default
    {
      wayland.windowManager.hyprland = {
        enable = true;
        nvidiaPatches = true;
        extraConfig = import ../dotfiles/hyprland.nix {inherit theme;};
      };
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

      xresources.extraConfig = ''
        ! enable dynamic colors
        URxvt*dynamicColors: on

        ! 0: Black
        URxvt*color0 : ${theme.normal.black}
        URxvt*color8 : ${theme.light.black}

        ! 1: Red
        URxvt*color1: ${theme.normal.red}
        URxvt*color9: ${theme.light.red}

        ! 2: Green
        URxvt*color2 : ${theme.normal.green}
        URxvt*color10 : ${theme.light.green}

        ! 3. Yellow/Orange
        URxvt*color3: ${theme.normal.yellow}
        URxvt*color11: ${theme.light.yellow}

        ! 4. Blue
        URxvt*color4: ${theme.normal.blue}
        URxvt*color12: ${theme.light.blue}

        ! 5. Magenta
        URxvt*color5 : ${theme.normal.magenta}
        URxvt*color13 : ${theme.light.magenta}

        ! 6. Cyan
        URxvt*color6 : ${theme.normal.cyan}
        URxvt*color14 : ${theme.light.cyan}

        ! 7. White
        URxvt*color7 : ${theme.normal.white}
        URxvt*color15 : ${theme.light.white}

        URxvt*background: ${theme.background}
        URxvt*foreground: ${theme.foreground}
        URxvt*colorUL: ${theme.normal.blue}
        URxvt*borderColor: ${theme.background}

        !##############################################################################
        ! Fonts
        !##############################################################################

        Xft.dpi: 96
        Xft.antialias: true
        Xft.hinting: true
        Xft.rgba: rgb
        Xft.autohint: false
        Xft.hintstyle: hintfull
        Xft.lcdfilter: lcddefault

        !URxvt*font: xft:lemon:pixelsize=11:antialias=false,\
        !            [codeset=JISX0208]xft:Kochi Gothic,\
        !            [codeset=KSC5601]xft:Baekmuk Dotum,\
        !            xft:WenQuanYi Bitmap Song
        !URxvt*boldFont: xft:lemon:pixelsize=11:antialias=false,\
        !            [codeset=JISX0208]xft:Kochi Gothic,\
        !            [codeset=KSC5601]xft:Baekmuk Dotum,\
        !            xft:WenQuanYi Bitmap Song
        URxvt*font: xft:uushi:pixelsize=11:antialias=false,\
                    [codeset=JISX0208]xft:Kochi Gothic,\
                    [codeset=KSC5601]xft:Baekmuk Dotum,\
                    xft:WenQuanYi Bitmap Song
        URxvt*boldFont: xft:uushi:pixelsize=11:antialias=false,\
                    [codeset=JISX0208]xft:Kochi Gothic,\
                    [codeset=KSC5601]xft:Baekmuk Dotum,\
                    xft:WenQuanYi Bitmap Song
        URxvt*imFont: -*-Kochi Gothic-medium-r-normal--11-140-*-*-*-*-*-*

        !##############################################################################
        ! Scrolling and Cursor
        !##############################################################################

        URxvt*saveLines: 10000
        URxvt*scrollstyle: plain
        URxvt*scrollBar: false
        URxvt*cursorBlink: true
        URxvt*cursorUnderline: true

        !##############################################################################
        ! Keybindings
        !##############################################################################

        URxvt.perl-ext-common: default,clipboard

        !##############################################################################
        ! Various Settings
        !##############################################################################

        URxvt.perl-ext: default,matcher
        URxvt.matcher.button: 1
        URxvt.urlLauncher: /usr/bin/firefox
      '';
    }
  ];
}
