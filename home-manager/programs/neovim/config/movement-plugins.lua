-- Movement plugins
require('leap').add_default_mappings()
vim.keymap.del({'x', 'o'}, 'x')
vim.keymap.del({'x', 'o'}, 'X')
-- To set alternative keys for "exclusive" selection:
vim.keymap.set({'x', 'o'}, '<A-x>', '<Plug>(leap-forward-till)')
vim.keymap.set({'x', 'o'}, '<A-X>', '<Plug>(leap-backward-till)')
require('flit').setup{}
