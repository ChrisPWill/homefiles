{theme}: {
  enable = true;
  settings = {
    scroll_buffer_size = 10000;
    copy_on_select = false;
    pane_frames = false;
    theme = "custom";
    themes.custom = {
      fg = theme.foreground;
      bg = theme.background;
      black = theme.normal.black;
      red = theme.normal.red;
      green = theme.normal.green;
      yellow = theme.normal.yellow;
      blue = theme.normal.blue;
      magenta = theme.normal.magenta;
      cyan = theme.normal.cyan;
      white = theme.normal.white;
      orange = theme.normal.orange;
    };
  };
}
