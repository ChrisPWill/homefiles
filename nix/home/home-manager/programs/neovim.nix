{ pkgs }:
{
  enable = true;
  defaultEditor = true;

  viAlias = true;
  vimAlias = true;
  vimdiffAlias = true;

  plugins = with pkgs.vimPlugins; [
    bufferline-nvim
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

    -- leap
    require('leap').add_default_mappings()
  '';
}
