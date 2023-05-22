{
  pkgs,
  lib,
  theme,
  programsPath,
  ...
}: {
  homeDirPrefix = "/Users";
  extraPrograms = {
    vscode = import (programsPath + "/vscode.nix") {inherit theme;};
  };
  extraPackages = [];
  extraModules = [];
}
