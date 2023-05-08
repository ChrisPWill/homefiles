-- nvim-tree
require("nvim-tree").setup({
  renderer = {
    group_empty = true,
  },
})
vim.keymap.set('n', '<leader>ntt', '<cmd>NvimTreeFindFile<cr><cmd>NvimTreeFocus<cr>', { noremap = true })
vim.keymap.set('n', '<leader>ntf', '<cmd>NvimTreeFindFile<cr>', { noremap = true })
vim.keymap.set('n', '<leader>ntr', '<cmd>NvimTreeRefresh<cr>', { noremap = true })
vim.keymap.set('n', '<leader>nt[', '<cmd>NvimTreeCollapse<cr>', { noremap = true })
vim.keymap.set('n', '<leader>ntx', '<cmd>NvimTreeClose<cr>', { noremap = true })
