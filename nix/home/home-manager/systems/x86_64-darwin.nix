{ pkgs, lib }:

{
  homeDirPrefix = "/Users";
  extraPrograms = {
    home-manager = { enable = true; };
  };
  extraModules = [];
}
