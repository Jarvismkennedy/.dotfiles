vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")
vim.keymap.set('v', '<leader>y', '"+y')
vim.keymap.set('v', '<leader>p', '"+p')
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')
-- vim.keymap.set('n', '<leader>e', '<cmd>Ex<CR>')
vim.keymap.set('v', '<leader>fw', 'gq')

vim.keymap.set('n', 'n', 'nzz')
vim.keymap.set('n', 'N', 'Nzz')
vim.keymap.set('v', 'n', 'nzz')
vim.keymap.set('v', 'N', 'Nzz')

-- for resizing splits
vim.keymap.set('n', '<M-,>', '<c-w>5<')
vim.keymap.set('n', '<M-.>', '<c-w>5>')
vim.keymap.set('n', '<M-h>', '<c-w>+')
vim.keymap.set('n', '<M-e>', '<c-w>-')

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>')
