{
  pkgs,
  lib,
  theme,
  programsPath,
  ...
}: {
  homeDirPrefix = "/Users";
  extraPrograms = {
    alacritty = import (programsPath + "/alacritty.nix") {
      transparency = 0.95;
      inherit theme;
    };
    vscode = import (programsPath + "/vscode.nix") {inherit theme;};
  };
  extraPackages = [];
  extraModules = [];
}
