{
  pkgs,
  pkgs-unstable,
  lib,
  enabledLanguages ? [],
  theme,
  enableCopilot ? false,
  ...
}: let
  languageServerConfigFiles = {
    dockerfile = "dockerfile-language-server-config.lua";
    json = "json-language-server-config.lua";
    lua = "lua-language-server-config.lua";
    nix = "nix-language-server-config.lua";
    rust = "rust-language-server-config.lua";
    typescript = "tsserver-config.lua";
    yaml = "yaml-language-server-config.lua";
  };
  languagesWithLanguageServer = builtins.filter (x: builtins.hasAttr x languageServerConfigFiles) enabledLanguages;
  generateLanguageConfigPath = file: (builtins.readFile (./language-servers + ("/" + file)));
  luaConfigs =
    [
      (builtins.readFile ./plugin-config/nvim-tree.lua)
      (builtins.readFile ./plugin-config/orgmode.lua)
      (builtins.readFile ./plugin-config/formatter.lua)
      (builtins.readFile ./plugin-config/bufferline.lua)
      (builtins.readFile ./plugin-config/telescope.lua)
      (builtins.readFile ./plugin-config/formatter.lua)
      (builtins.readFile ./plugin-config/movement-plugins.lua)
    ]
    ++ builtins.map (language: generateLanguageConfigPath (languageServerConfigFiles.${language})) languagesWithLanguageServer
    ++ ["lsp.setup()"] # Call LSP setup at the end
    ++ ["whichkey.setup({})"]; # Call whichkey setup at the end

  languageToTreesitterName = language:
    {
      # Add language name mappings here if treesitter uses a different name
      # "sourceLanguage" = "treesitterLanguage";
    }
    .${language}
    or language;
  unstableVim = pkgs-unstable.vimPlugins;
  copilotConfig =
    if enableCopilot
    then ''
      require("copilot").setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
      })
      require('copilot_cmp').setup()
      cmp.setup({
        sources = {
          {name = 'copilot'},
          {name = 'nvim_lsp'},
        },
        mapping = {
          ['<CR>'] = cmp.mapping.confirm({
            -- documentation says this is important.
            -- I don't know why.
            behavior = cmp.ConfirmBehavior.Replace,
            select = false,
          }),
          ['<C-Space>'] = cmp.mapping.complete(),
        }
      })
    ''
    else "";
in {
  enable = true;
  defaultEditor = true;

  viAlias = true;
  vimAlias = true;
  vimdiffAlias = true;

  plugins = with pkgs.vimPlugins;
    [
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
      # unstableVim.lsp-zero-nvim
      # unstableVim.nvim-lspconfig
      # (unstableVim.nvim-treesitter.withPlugins (p: builtins.map languageToTreesitterName enabledLanguages))
      trouble-nvim
      # unstableVim.formatter-nvim

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
      # unstableVim.mini-nvim
      nvim-surround

      # Extras
      orgmode
    ]
    ++ (
      if false && enableCopilot
      then [unstableVim.copilot-lua unstableVim.copilot-cmp]
      else []
    );

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

      -- Notify
      require("notify").setup({
        background_colour = "${theme.background}",
      })

      -- which-key
      local whichkey = require("which-key")

      whichkey.register({
        ["<A-k>"] = { "<cmd>WhichKey<cr>", "Which Key" },
      }, { mode = "n" })

      whichkey.register({
        ["<A-k>"] = { "<cmd>WhichKey ''' v<CR>", "Which Key (visual)" },
      }, { mode = "v" })

      whichkey.register({
        ["<A-k>"] = { "<cmd>WhichKey ''' i<CR>", "Which Key (insert)" },
      }, { mode = "i" })

      whichkey.register({
        ["<A-k>"] = { "<cmd>WhichKey ''' c<CR>", "Which Key (command)" },
      }, { mode = "c" })

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

      whichkey.register({
        ["<leader>xx"] = { "<cmd>TroubleToggle<cr>", "Toggle Trouble (listing errors etc.)" },
      }, { mode = "n" })

      -- LSP
      local lsp = require('lsp-zero').preset("manual-setup")

      lsp.on_attach(function(client, bufnr)
        whichkey.register({
          ["<A-]>"] = { "<C-I>", "Go to newer jump" },
          ["<A-[>"] = { "<C-O>", "Go to older jump" },
          K = {
            name = "LSP",
            A = { vim.lsp.buf.code_action, "Code Action", },
            K = { vim.lsp.buf.hover, "Show LSP Info", },
            E = { vim.lsp.buf.rename, "Rename using LSP", },
            D = { vim.lsp.buf.definition, "Open LSP Definition", },
            F = { function() vim.lsp.buf.format({ async = false, timeout_ms = 10000, }) end, "Format", },
            I = { vim.lsp.buf.implementation, "Open LSP Implementation", },
            N = { vim.diagnostic.goto_next, "Goto next LSP Diagnostic", },
            P = { vim.diagnostic.goto_prev, "Goto previous LSP Diagnostic", },
            R = { require('telescope.builtin').lsp_references, "Show LSP References", },
            T = { "<cmd>Telescope diagnostics<cr>", "Show LSP diagnostics", },
          },
        })
      end)

      lsp.setup_servers({'tsserver'})

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
      -- cmp for later config
      local cmp = require('cmp')

    ''
    + (builtins.concatStringsSep "\n" luaConfigs)
    + copilotConfig;
}
