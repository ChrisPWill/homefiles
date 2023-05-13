-- Lua language server (conditionally loaded in main Nix file)
lspconfig.lua_ls.setup {
  settings = {
    diagnostics = {
      -- Get the language server to recognize the `vim` global
      globals = {'vim'},
    },
    workspace = {
      -- Make the server aware of Neovim runtime files
      library = vim.api.nvim_get_runtime_file("", true),
    },
  }
}
