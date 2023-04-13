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
    # Completion and snippets
    cmp-nvim-lsp
    luasnip
    nvim-cmp

    # Movement, navigation, and finding
    flit-nvim
    leap-nvim
    telescope-nvim

    # LSP, linters, and language tooling
    lsp-zero-nvim
    nvim-lspconfig
    nvim-treesitter.withAllGrammars
    trouble-nvim

    # Notifications and messages
    nvim-notify

    # User Interface Components
    nui-nvim
    bufferline-nvim
    noice-nvim
    vim-illuminate
    vim-gitgutter
    vim-airline
    vim-fugitive

    # Editing, text manipulation, and utilities
    mini-nvim
    nvim-surround
  ];

  extraConfig = ''
    set number
    set background=dark
    set updatetime=100
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

    -- vim-gitgutter setup
    vim.cmd('let g:gitgutter_enabled = 1')
    vim.cmd('let g:gitgutter_map_keys = 1')
    vim.cmd('let g:gitgutter_sign_added = "+"')
    vim.cmd('let g:gitgutter_sign_modified = "~"')
    vim.cmd('let g:gitgutter_sign_removed = "_"')

    -- vim-airline setup
    vim.cmd('let g:airline_powerline_fonts = 1')
  '' + (builtins.concatStringsSep "\n" luaConfigs);
}
