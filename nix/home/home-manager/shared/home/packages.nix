{
  pkgs,
  extraPackages ? [],
}:
with pkgs;
  [
    eureka-ideas
    fd
    fx
    kondo
    (pkgs.nerdfonts.override {fonts = ["FantasqueSansMono"];})
    powerline-go
    rargs
    ripgrep
    tealdeer
    alejandra
    lua-language-server
    nil
  ]
  ++ extraPackages
