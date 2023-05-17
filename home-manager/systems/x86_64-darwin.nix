{
  pkgs,
  lib,
  theme,
}: {
  homeDirPrefix = "/Users";
  extraPrograms = {
    vscode = import ../programs/vscode.nix {inherit theme;};
  };
  extraPackages = [];
  extraModules = [];
}
