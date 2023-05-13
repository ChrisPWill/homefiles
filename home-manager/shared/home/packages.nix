{
  pkgs,
  extraPackages ? [],
}:
with pkgs;
  [
    (pkgs.nerdfonts.override {fonts = ["FantasqueSansMono"];})
    alejandra
    eureka-ideas
    fd
    fx
    gcc
    kondo
    lua-language-server
    nil
    powerline-go
    rargs
    ripgrep
    spotify-tui
    tealdeer
  ]
  ++ extraPackages
