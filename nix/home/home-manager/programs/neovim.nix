{ pkgs }:
{
  enable = true;
  defaultEditor = true;

  viAlias = true;
  vimAlias = true;
  vimdiffAlias = true;

  plugins = with pkgs.vimPlugins; [
    bufferline-nvim
    flit-nvim
    leap-nvim
    mini-nvim
    noice-nvim
    nui-nvim
    nvim-notify
    nvim-treesitter.withAllGrammars
    vim-illuminate
  ];

  extraConfig = ''
    set number
    set background=dark
    colorscheme default
  '';

  extraLuaConfig = ''
    -- Theming
    vim.opt.termguicolors = true

    -- bufferline config
    require('bufferline').setup{}

    -- movement plugins
    require('leap').add_default_mappings()
    require('flit').setup{}

    -- mini plugins
    require('mini.bracketed').setup()
    require('mini.comment').setup()
    require('mini.map').setup()
    require('mini.pairs').setup()
    require('mini.surround').setup()
    require('mini.trailspace').setup()
  '';
}
