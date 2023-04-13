{
  pkgs,
  enabledLanguages ? [],
}: let
  luaConfigs =
    [
      (builtins.readFile ./neovim/formatter-config.lua)
      (builtins.readFile ./neovim/bufferline-config.lua)
      (builtins.readFile ./neovim/telescope-config.lua)
      (builtins.readFile ./neovim/formatter-config.lua)
    ]
    ++ (
      if builtins.elem "typescript" enabledLanguages
      then [(builtins.readFile ./neovim/tsserver-config.lua)]
      else []
    )
    ++ (
      if builtins.elem "lua" enabledLanguages
      then [(builtins.readFile ./neovim/lua-language-server-config.lua)]
      else []
    )
    ++ (
      if builtins.elem "dockerfile" enabledLanguages
      then [(builtins.readFile ./neovim/dockerfile-language-server-config.lua)]
      else []
    );
  languageToTreesitterName = language:
    {
      # Add language name mappings here if treesitter uses a different name
      # "sourceLanguage" = "treesitterLanguage";
    }
    .${language}
    or language;
in {
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
    (nvim-treesitter.withPlugins (p: builtins.map languageToTreesitterName enabledLanguages))
    trouble-nvim
    formatter-nvim

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
    nvim-web-devicons

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

  extraLuaConfig =
    ''
      -- Global settings
      local opt = vim.opt
      opt.termguicolors = true

      -- Tabs
      opt.tabstop = 2
      opt.smartindent = true
      opt.shiftwidth = 2
      opt.expandtab = true

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
      vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>",
        {silent = true, noremap = true}
      )

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

      -- enabled languages for later config
      local enabledLanguages = vim.json.decode('${builtins.toJSON enabledLanguages}')
      local function contains(list, value)
        for _, v in ipairs(list) do
          if v == value then
            return true
          end
        end
        return false
      end

      -- lspconfig for later config
      local lspconfig = require('lspconfig')
    ''
    + (builtins.concatStringsSep "\n" luaConfigs);
}
