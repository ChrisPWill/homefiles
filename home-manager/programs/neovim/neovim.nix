{
  pkgs,
  pkgs-unstable,
  lib,
  enabledLanguages ? [],
  theme,
}: let
  generateLanguageConfig = language: path:
    if builtins.elem language enabledLanguages
    then [(builtins.readFile (./language-servers + ("/" + path)))]
    else [];
  luaConfigs =
    [
      (builtins.readFile ./config/which-key.lua)
      (builtins.readFile ./config/nvim-tree.lua)
      (builtins.readFile ./config/orgmode.lua)
      (builtins.readFile ./config/formatter.lua)
      (builtins.readFile ./config/bufferline.lua)
      (builtins.readFile ./config/telescope.lua)
      (builtins.readFile ./config/formatter.lua)
    ]
    ++ generateLanguageConfig "typescript" "tsserver-config.lua"
    ++ generateLanguageConfig "lua" "lua-language-server-config.lua"
    ++ generateLanguageConfig "nix" "nix-language-server-config.lua"
    ++ generateLanguageConfig "rust" "rust-language-server-config.lua"
    ++ generateLanguageConfig "dockerfile" "dockerfile-language-server-config.lua"
    ++ ["lsp.setup()"]; # Call LSP setup at the end

  languageToTreesitterName = language:
    {
      # Add language name mappings here if treesitter uses a different name
      # "sourceLanguage" = "treesitterLanguage";
    }
    .${language}
    or language;
  unstableVim = pkgs-unstable.vimPlugins;
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
    unstableVim.lsp-zero-nvim
    unstableVim.nvim-lspconfig
    (nvim-treesitter.withPlugins (p: builtins.map languageToTreesitterName enabledLanguages))
    trouble-nvim
    unstableVim.formatter-nvim

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
    nvim-colorizer-lua

    # Editing, text manipulation, and utilities
    unstableVim.mini-nvim
    nvim-surround

    # Extras
    orgmode
  ];

  extraConfig =
    ''
      set number
      set background=dark

      set updatetime=100

      " Work around for telescope colour issue
      :hi NormalFloat ctermfg=LightGrey
    ''
    + (import ./colorscheme.nix {
      inherit theme;
      inherit lib;
    });

  extraLuaConfig =
    ''
      -- Global settings
      local opt = vim.opt
      local g = vim.g;

      require 'colorizer'.setup()
      opt.termguicolors = true

      -- Disable netrw
      g.loaded_netrw = 1
      g.loaded_netrwPlugin = 1

      -- Tabs
      opt.tabstop = 2
      opt.smartindent = true
      opt.shiftwidth = 2
      opt.expandtab = true

      -- which-key
      local whichkey = require('which-key');

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


      -- Surround plugin
      require('nvim-surround').setup({})

      -- vim-gitgutter setup
      vim.cmd('let g:gitgutter_enabled = 1')
      vim.cmd('let g:gitgutter_map_keys = 1')
      vim.cmd('let g:gitgutter_sign_added = "+"')
      vim.cmd('let g:gitgutter_sign_modified = "~"')
      vim.cmd('let g:gitgutter_sign_removed = "_"')

      -- vim-airline setup
      vim.cmd('let g:airline_powerline_fonts = 1')

      -- LSP, linters, and other language tooling configuration
      -- Linter
      require("trouble").setup {}
      vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>",
        {silent = true, noremap = true}
      )

      -- LSP
      local lsp = require('lsp-zero').preset('manual-setup')

      lsp.on_attach(function(client, bufnr)
        whichkey.register({
          ["<leader>"] = {
            k = {
              name = "LSP",
              a = { vim.lsp.buf.code_action, "Code Action", },
              K = { vim.lsp.buf.hover, "Show LSP Info", },
              R = { vim.lsp.buf.rename, "Rename using LSP", },
              d = { vim.lsp.buf.definition, "Open LSP Definition", },
              F = { function() vim.lsp.buf.format({ async = false, timeout_ms = 10000, }) end, "Format", },
              i = { vim.lsp.buf.implementation, "Open LSP Implementation", },
              n = { vim.diagnostic.goto_next, "Goto next LSP Diagnostic", },
              p = { vim.diagnostic.goto_prev, "Goto previous LSP Diagnostic", },
              r = { require('telescope.builtin').lsp_references, "Show LSP References", },
              t = { "<cmd>Telescope diagnostics<cr>", "Show LSP diagnostics", },
            },
          },
        })
      end)

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
