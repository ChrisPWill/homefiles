-- Load custom treesitter grammar for org filetype
require('orgmode').setup{}
require('orgmode').setup_ts_grammar()

-- Treesitter configuration
local parser_install_dir = vim.fn.stdpath("cache") .. "/treesitters"
vim.fn.mkdir(parser_install_dir, "p")
-- Prevents reinstall of treesitter plugins every boot
vim.opt.runtimepath:append(parser_install_dir)
require('nvim-treesitter.configs').setup {
  -- If TS highlights are not enabled at all, or disabled via `disable` prop,
  -- highlighting will fallback to default Vim syntax highlighting
  highlight = {
    enable = true,
    -- Required for spellcheck, some LaTex highlights and
    -- code block highlights that do not have ts grammar
    additional_vim_regex_highlighting = {'org'},
  },
  ensure_installed = {'org'}, -- Or run :TSUpdate org
  parser_install_dir = parser_install_dir,
}

require('orgmode').setup({
  org_agenda_files = {'$HOME/org-mode/**/*'},
  org_default_notes_file = '$HOME/org-mode/default/notes.org',
})

require('cmp').setup({
  sources = {
    { name = 'orgmode' }
  }
})
