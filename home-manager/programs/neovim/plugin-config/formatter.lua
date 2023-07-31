local filetype = {}

-- Formatter configurations for any filetype
filetype["*"] = {
  require("formatter.filetypes.any").remove_trailing_whitespace
}

if contains(enabledLanguages, "typescript") then
  filetype["typescript"] = {
    require("formatter.filetypes.typescript").prettier,
    require("formatter.filetypes.typescriptreact").prettier
  }
end

if contains(enabledLanguages, "javascript") then
  filetype["javascript"] = {
    require("formatter.filetypes.javascript").prettier,
    require("formatter.filetypes.javascriptreact").prettier
  }
end


if contains(enabledLanguages, "graphql") then
  filetype["graphql"] = {
    require("formatter.filetypes.graphql").prettier
  }
end

if contains(enabledLanguages, "html") then
  filetype["html"] = {
    require("formatter.filetypes.html").prettier
  }
end

if contains(enabledLanguages, "yaml") then
  filetype["yaml"] = {
    require("formatter.filetypes.yaml").prettier
  }
end

if contains(enabledLanguages, "markdown") then
  filetype["markdown"] = {
    require("formatter.filetypes.markdown").prettier
  }
end

if contains(enabledLanguages, "terraform") then
  filetype["terraform"] = {
    require("formatter.filetypes.terraform").terraformfmt
  }
end

if contains(enabledLanguages, "nix") then
  filetype["nix"] = {
    require("formatter.filetypes.nix").alejandra
  }
end

-- ... add other language conditions here ...

require("formatter").setup {
  logging = true,
  log_level = vim.log.levels.WARN,
  filetype = filetype
}


vim.keymap.set('n', '<A-f>', 'Format<CR>', { noremap = true })
vim.keymap.set('n', '<A-F>', 'FormatWrite<CR>', { noremap = true })
vim.cmd([[
  augroup FormatAutogroup
    autocmd!
    autocmd BufWritePost * FormatWrite
  augroup END
]])
vim.cmd([[
  command! WriteNoFormat noautocmd write
  command! WNF noautocmd write
]])
