-- TypeScript language server (conditionally loaded in main Nix file)
lspconfig.tsserver.setup {
  on_attach = function(client, bufnr)
    lsp.default_keymaps({buffer = bufnr})
  end,
}
