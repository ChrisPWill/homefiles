{ pkgs, lib }:

{
  homeDirPrefix = "/Users";
  extraPrograms = {
    home-manager = { enable = true; };
  };
  extraPackages = [];
  extraModules = [];
}
