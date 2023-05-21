{
  pkgs,
  pkgs-unstable,
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
    pkgs-unstable.lua-language-server
    nil
    nodePackages.prettier
    powerline-go
    python311
    rargs
    ripgrep
    socat
    spotify-tui
    tealdeer
  ]
  ++ extraPackages
