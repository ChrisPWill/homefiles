{
  pkgs,
  transparency ? "0.8",
  theme,
  systemIsDarwin ? false,
  ...
}: {
  enable = true;
  package = pkgs.alacritty;
  settings = {
    window = {
      option_as_alt =
        if systemIsDarwin
        then "OnlyLeft"
        else null;
      opacity = transparency;
      decorations_theme_variant = "Dark";
      decorations = "none";
    };
    colors = {
      primary = {
        background = theme.background;
        foreground = theme.foreground;
      };
      normal = {
        black = theme.normal.black;
        white = theme.normal.white;
        red = theme.normal.red;
        green = theme.normal.green;
        yellow = theme.normal.yellow;
        blue = theme.normal.blue;
        cyan = theme.normal.cyan;
        magenta = theme.normal.magenta;
      };
    };
    scrolling.history = 20000;
    font = {
      normal.family = "FantasqueSansM Nerd Font Mono";
      size = 20.0;
    };
    cursor = {
      style.shape = "Beam";
      style.blinking = "On";
      vi_mode_style.shape = "Block";
      vi_mode_style.blinking = "On";
    };
    selection.save_to_clipboard = true;
  };
}
