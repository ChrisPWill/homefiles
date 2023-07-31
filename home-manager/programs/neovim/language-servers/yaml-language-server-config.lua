lspconfig.yamlls.setup({
  on_attach=on_attach,
  settings= {
    yaml = {
      schemaStore = {
        enable = true,
      },
      schemas = {
        ['https://micros.prod.atl-paas.net/schema.json'] = "/**/(*.sd.y*ml|service-descriptor.y*ml)",
      },
    },
  }
})
