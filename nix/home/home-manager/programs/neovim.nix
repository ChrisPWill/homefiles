{ pkgs }:
{
  enable = true;
  defaultEditor = true;

  viAlias = true;
  vimAlias = true;
  vimdiffAlias = true;

  extraConfig = ''
    set number
    set background=dark
    colorscheme default
  '';
}
