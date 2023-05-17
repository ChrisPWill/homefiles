{
  utils = {
    # Converts #xxxxxx to rgb(xxxxxx)
    toRgb = color: (builtins.replaceStrings ["#"] ["rgb("] color) + ")";
  };
  background = "#202020";
  background-defocused = "#262626";
  foreground = "#e8e8e8";
  normal = {
    white = "#e8e8e8";
    silver = "#c1c1d1";
    lightgray = "#c8c8c8";
    gray = "#585858";
    dimgray = "#383838";
    black = "#303030";
    blue = "#268bd2";
    green = "#859900";
    cyan = "#2aa198";
    orange = "#ffa996";
    yellow = "#d1bc36";
    lightred = "#fc423f";
    red = "#dc322f";
    magenta = "#d33682";
  };
  light = {
    white = "#f6f6f6";
    silver = "#d1d1e1";
    lightgray = "#dfdfdf";
    dimgray = "#afafaf";
    gray = "#989898";
    black = "#262626";
    blue = "#1b6497";
    green = "#6a6a6a";
    cyan = "#71dad2";
    yellow = "#edda61";
    orange = "#f5b1a2";
    lightred = "#fc728f";
    red = "#cb4b16";
    magenta = "#e481b1";
  };
}
