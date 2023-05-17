{theme}: let
  colors = theme.normal;
in {
  enable = true;
  userSettings = {
    editor = {
      fontFamily = "'FantasqueSansMono Nerd Font Mono', Menlo, Monaco, 'Courier New', monospace";
      defaultFormatter = "esbenp.prettier-vscode";
      formatOnSave = true;
    };
    window = {
      autoDetectColorScheme = true;
      zoomLevel = 1;
    };

    javascript.updateImportsOnFileMove.enabled = "never";

    terminal.integrated.shellIntegration.history = 0;

    debug.javascript.autoAttachFilter = "always";
  };
}
