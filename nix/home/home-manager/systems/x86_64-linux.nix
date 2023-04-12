{ pkgs, lib }:

{
  homeDirPrefix = "/home";
  extraPrograms = {
    home-manager = { enable = true; };
    bash = {
      enable = true;
    };

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

  extraModules = [{
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
!##############################################################################
! Global Colorscheme Notes
!##############################################################################
! White (a snow white):         #f9f9f9
! Black (a faded black):        #707070
! Darker Gray:                  #adadad
! Gray (a dusky gray):          #e0e0e0
! Green:                        #abd8a5
! Lighter Gray:                 #ebebeb
! Red/orange:                   #FFA996
! Darker Red (faded burgundy):  #a27b7f

! enable dynamic colors
URxvt*dynamicColors: on

! 0: Black
URxvt*color0 : #303030
URxvt*color8 : #262626

! 1: Red
URxvt*color1: #dc322f
! 9: Orange
URxvt*color9: #cb4b16

! 2: Green
URxvt*color2 : #859900
URxvt*color10 : #6a6a6a

! 3. Yellow/Orange
URxvt*color3: #b58900
URxvt*color11: #777777

! 4. Blue
URxvt*color4: #268bd2
URxvt*color12: #1b6497

! 5. Magenta
URxvt*color5 : #d33682
URxvt*color13 : #e481b1

! 6. Cyan
URxvt*color6 : #2aa198
URxvt*color14 : #71dad2

! 7. White
URxvt*color7 : #e8e8e8
URxvt*color15 : #f6f6f6

URxvt*background: #262626
URxvt*foreground: #919191
URxvt*colorUL: #268bd2
URxvt*borderColor: #262626

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
  }];
}
