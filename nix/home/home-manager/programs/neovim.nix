{ pkgs }:
{
  enable = true;
  defaultEditor = true;

  viAlias = true;
  vimAlias = true;
  vimdiffAlias = true;

  plugins = with pkgs.vimPlugins; [
    bufferline-nvim
    mini-nvim
    noice-nvim
    nui-nvim
    nvim-notify
    nvim-treesitter.withAllGrammars
  ];

  extraConfig = ''
    set number
    set background=dark
    colorscheme default
  '';
}
