{ pkgs, lib }:

{
  homeDirPrefix = "/Users";
  extraPrograms = {
    kitty = { enable = true; };
    home-manager = { enable = true; };
  };
}
