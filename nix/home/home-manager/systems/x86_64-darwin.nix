{ pkgs, lib }:

{
  homeDirPrefix = "/Users";
  extraPrograms = {
    zsh = {
      enable = true;
    };
    kitty = { enable = true; };
    home-manager = { enable = true; };
  };
}
