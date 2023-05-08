-- Which key
require("which-key").setup({})
vim.keymap.set('n', '<M-k>', '<cmd>WhichKey<cr>', { noremap = true })
vim.keymap.set('v', '<M-k>', "<cmd>WhichKey ''\'' v<CR>", { noremap = true })
vim.keymap.set('i', '<M-k>', "<cmd>WhichKey ''\'' i<CR>", { noremap = true })
vim.keymap.set('c', '<M-k>', "<cmd>WhichKey ''\'' c<CR>", { noremap = true })
