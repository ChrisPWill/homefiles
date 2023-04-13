-- Telescope configuration
-- Set up telescope key mappings
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>', {})
vim.keymap.set('n', '<leader>fr', '<cmd>Telescope live_grep<cr>', {})
vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<cr>', {})
vim.keymap.set('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', {})
vim.keymap.set('n', '<leader>ft', '<cmd>Telescope treesitter<cr>', {})
vim.keymap.set('n', '<leader>fgs', '<cmd>Telescope git_status<cr>', {})
vim.keymap.set('n', '<leader>fgb', '<cmd>Telescope git_branches<cr>', {})
vim.keymap.set('n', '<leader>fgcc', '<cmd>Telescope git_commits<cr>', {})
vim.keymap.set('n', '<leader>fgcb', '<cmd>Telescope git_bcommits<cr>', {})
