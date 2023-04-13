local filetype = {}

-- Formatter configurations for any filetype
filetype["*"] = {
  require("formatter.filetypes.any").remove_trailing_whitespace
}

if contains(enabledLanguages, "typescript") then
  filetype["typescript"] = {
    require("formatter.filetypes.typescript").prettier
  }
end

-- ... add other language conditions here ...

require("formatter").setup {
  logging = true,
  log_level = vim.log.levels.WARN,
  filetype = filetype
}

vim.cmd([[
  augroup FormatAutogroup
    autocmd!
    autocmd BufWritePost * FormatWrite
  augroup END
]])
