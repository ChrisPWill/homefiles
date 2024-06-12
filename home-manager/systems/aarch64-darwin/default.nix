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
  };
  extraPackages = [];
  extraModules = [
    {
      home.file.".aerospace.toml".source = ./aerospace.toml;
    }
  ];
}
