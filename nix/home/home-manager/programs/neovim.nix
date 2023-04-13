{ pkgs, enabledLanguages ? [] }:
let
  luaConfigs = [
    (builtins.readFile ./neovim/bufferline-config.lua)
    (builtins.readFile ./neovim/telescope-config.lua)
  ] ++ (if builtins.elem "typescript" enabledLanguages then [(builtins.readFile ./neovim/tsserver-config.lua)] else []);
in
{
  enable = true;
  defaultEditor = true;

  viAlias = true;
  vimAlias = true;
  vimdiffAlias = true;

  plugins = with pkgs.vimPlugins; [
    # Buffer and tab management
    bufferline-nvim

    # Completion and snippets
    cmp-nvim-lsp
    luasnip
    nvim-cmp

    # Movement and navigation
    flit-nvim
    leap-nvim
    telescope-nvim

    # LSP, linters, and language tooling
    lsp-zero-nvim
    nvim-lspconfig
    nvim-notify
    nvim-treesitter.withAllGrammars
    trouble-nvim

    # Editing and text manipulation
    mini-nvim
    noice-nvim
    nui-nvim
    nvim-surround
    vim-illuminate
  ];

  extraConfig = ''
    set number
    set background=dark
    colorscheme default

    " Work around for telescope colour issue
    :hi NormalFloat ctermfg=LightGrey
  '';

  extraLuaConfig = ''
    -- Global settings
    vim.opt.termguicolors = true

    -- Movement plugins
    require('leap').add_default_mappings()
    require('flit').setup{}

    -- Mini plugins
    require('mini.bracketed').setup()
    require('mini.comment').setup()
    require('mini.map').setup()
    require('mini.pairs').setup()
    require('mini.trailspace').setup()

    -- Surround plugin
    require('nvim-surround').setup({})

    -- LSP, linters, and other language tooling configuration
    -- Linter
    require("trouble").setup {}

    -- LSP
    local lsp = require('lsp-zero').preset('manual-setup')

    lsp.on_attach(function(client, bufnr)
      lsp.default_keymaps({buffer = bufnr})
    end)

    lsp.setup()
  '' + (builtins.concatStringsSep "\n" luaConfigs);
}
