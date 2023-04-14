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
    fzf-vim
    which-key-nvim

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
    nvim-tree-lua

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
      local g = vim.g;

      opt.termguicolors = true

      -- Disable netrw
      g.loaded_netrw = 1
      g.loaded_netrwPlugin = 1

      -- Tabs
      opt.tabstop = 2
      opt.smartindent = true
      opt.shiftwidth = 2
      opt.expandtab = true

      -- Movement plugins
      require('leap').add_default_mappings()
      vim.keymap.del({'x', 'o'}, 'x')
      vim.keymap.del({'x', 'o'}, 'X')
      -- To set alternative keys for "exclusive" selection:
      vim.keymap.set({'x', 'o'}, '<M-x>', '<Plug>(leap-forward-till)')
      vim.keymap.set({'x', 'o'}, '<M-X>', '<Plug>(leap-backward-till)')
      require('flit').setup{}

      -- Mini plugins
      require('mini.bracketed').setup()
      require('mini.comment').setup()
      require('mini.indentscope').setup({
        draw = {
          animation = require('mini.indentscope').gen_animation.none()
        }
      })
      require('mini.map').setup()
      require('mini.pairs').setup()
      require('mini.splitjoin').setup()
      require('mini.trailspace').setup()

      -- Which key
      require("which-key").setup({})
      vim.keymap.set('n', '<M-k>', '<cmd>WhichKey<cr>', { noremap = true })
      vim.keymap.set('v', '<M-k>', "<cmd>WhichKey ''\'' v<CR>", { noremap = true })
      vim.keymap.set('i', '<M-k>', "<cmd>WhichKey ''\'' i<CR>", { noremap = true })
      vim.keymap.set('c', '<M-k>', "<cmd>WhichKey ''\'' c<CR>", { noremap = true })

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

      -- nvim-tree
      require("nvim-tree").setup({
        renderer = {
          group_empty = true,
        },
      })

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
