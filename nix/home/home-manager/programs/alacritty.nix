{theme}: {
  enable = true;
  settings = {
    window = {
      opacity = 0.98;
      decorations_theme_variant = "Dark";
      decorations = "none";
    };
    colors = {
      primary = {
        background = theme.black;
        foreground = theme.white;
      };
      normal = {
        black = theme.black;
        white = theme.white;
        red = theme.red;
        green = theme.green;
        yellow = theme.yellow;
        blue = theme.blue;
        cyan = theme.cyan;
      };
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
    selection.save_to_clipboard = false;
  };
}
