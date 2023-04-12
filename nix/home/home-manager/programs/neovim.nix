{ pkgs }:
{
  enable = true;
  defaultEditor = true;

  viAlias = true;
  vimAlias = true;
  vimdiffAlias = true;

  plugins = with pkgs.vimPlugins; [
    bufferline-nvim
    cmp-nvim-lsp
    flit-nvim
    luasnip
    leap-nvim
    lsp-zero-nvim
    mini-nvim
    noice-nvim
    nui-nvim
    nvim-cmp
    nvim-lspconfig
    nvim-notify
    nvim-surround
    nvim-treesitter.withAllGrammars
    telescope-nvim
    trouble-nvim
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
    require('mini.trailspace').setup()

    require('nvim-surround').setup({})

    -- telescope
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
    vim.keymap.set('n', '<leader>fr', builtin.live_grep, {})
    vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
    vim.keymap.set('n', '<leader>ft', builtin.treesitter, {})
    vim.keymap.set('n', '<leader>fgs', builtin.git_status, {})
    vim.keymap.set('n', '<leader>fgb', builtin.git_branches, {})
    vim.keymap.set('n', '<leader>fgcc', builtin.git_commits, {})
    vim.keymap.set('n', '<leader>fgcb', builtin.git_bcommits, {})

    -- LSP, linters, etc.
    -- Linter
    require("trouble").setup {}
    -- LSP
    local lsp = require('lsp-zero').preset({})

    lsp.on_attach(function(client, bufnr)
      lsp.default_keymaps({buffer = bufnr})
    end)

    lsp.setup()
  '';
}
