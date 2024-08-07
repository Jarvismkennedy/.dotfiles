vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")
vim.keymap.set('v', '<leader>y', '"+y')
vim.keymap.set('v', '<leader>p', '"+p')
vim.keymap.set('n', '<C-h>', '<Cmd>call VSCodeNotify("workbench.action.navigateLeft")<CR>')
vim.keymap.set('n', '<C-j>', '<Cmd>call VSCodeNotify("workbench.action.navigateDown")<CR>')
vim.keymap.set('n', '<C-k>', '<Cmd>call VSCodeNotify("workbench.action.navigateUp")<CR>')
vim.keymap.set('n', '<C-l>', '<Cmd>call VSCodeNotify("workbench.action.navigateRight")<CR>')
vim.keymap.set('n', 'za', '<Cmd>call VSCodeNotify("editor.fold")<CR>')
vim.keymap.set('n', '<leader>zm', '<Cmd>call VSCodeNotify("editor.foldAll")<CR>')
vim.keymap.set('n', '<leader>zr', '<Cmd>call VSCodeNotify("editor.unfoldAll")<CR>')

vim.keymap.set('n', '<leader>f1', '<Cmd>call VSCodeNotify("editor.foldLevel1")<CR>')
vim.keymap.set('n', '<leader>f2', '<Cmd>call VSCodeNotify("editor.foldLevel2")<CR>')
vim.keymap.set('n', '<leader>f3', '<Cmd>call VSCodeNotify("editor.foldLevel3")<CR>')
vim.keymap.set('n', '<leader>f4', '<Cmd>call VSCodeNotify("editor.foldLevel4")<CR>')

vim.keymap.set('n', '<leader>b', '<Cmd>call VSCodeNotify("editor.debug.action.toggleBreakpoint")<CR>')
vim.keymap.set('n', '<leader>rn', '<Cmd>call VSCodeNotify("editor.action.rename")<CR>')

vim.keymap.set('n', '<C-d>', '<Cmd>25j<CR>')
vim.keymap.set('n', '<C-b>', '<Cmd>25k<CR>')
