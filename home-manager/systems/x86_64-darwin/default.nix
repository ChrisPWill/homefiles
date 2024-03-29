{
  pkgs-unstable,
  lib,
  theme,
  programsPath,
  ...
}: {
  homeDirPrefix = "/Users";
  extraPrograms = {
    alacritty = import (programsPath + "/alacritty.nix") {
      pkgs = pkgs-unstable;
      transparency = 0.90;
      inherit theme;
      systemIsDarwin = true;
    };
    vscode = import (programsPath + "/vscode.nix") {
      inherit theme;
      pkgs = pkgs-unstable;
    };
  };
  extraPackages = [];
  extraModules = [];
}
