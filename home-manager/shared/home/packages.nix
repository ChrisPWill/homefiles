{
  pkgs,
  pkgs-unstable,
  extraPackages ? [],
}:
with pkgs;
  [
    (pkgs-unstable.nerdfonts.override {fonts = ["FantasqueSansMono"];})
    alejandra
    eureka-ideas
    fd
    fx
    gcc
    kondo
    pkgs-unstable.lua-language-server
    pkgs-unstable.obsidian
    nil
    nodePackages.prettier
    powerline-go
    python311
    rargs
    ripgrep
    socat
    spotify-tui
    tealdeer
    xsv
  ]
  ++ extraPackages
