{
  pkgs,
  lib,
}: {
  homeDirPrefix = "/Users";
  extraPrograms = {
    alacritty = {
      enable = true;
      settings = {
        window = {
          opacity = 0.9;
          decorations_theme_variant = "Dark";
          decorations = "none";
        };
        scrolling.history = 20000;
        font = {
          normal.family = "FantasqueSansMono Nerd Font Mono";
          size = 20.0;
        };
        cursor = {
          style.shape = "Beam";
          style.blinking = "On";
          vi_mode_style.shape = "Block";
          vi_mode_style.blinking = "On";
        };
      };
    };
  };
  extraPackages = [];
  extraModules = [];
}
