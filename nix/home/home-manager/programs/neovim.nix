{ pkgs }:
{
  enable = true;
  defaultEditor = true;

  viAlias = true;
  vimAlias = true;
  vimdiffAlias = true;

  plugins = with pkgs.vimPlugins; [
    noice-nvim
    nui-nvim
    nvim-treesitter.withAllGrammars
  ];

  extraConfig = ''
    set number
    set background=dark
    colorscheme default
  '';
}
