vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    }
end

vim.opt.rtp:prepend(lazypath)
local plugins = require 'plugins'

if vim.g.vscode then
    vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
    vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")
    vim.keymap.set('v', '<leader>y', '"+y')
    vim.keymap.set('v', '<leader>p', '"+p')
    vim.keymap.set('n', '<C-h>', '<Cmd>call VSCodeNotify("workbench.action.navigateLeft")<CR>')
    vim.keymap.set('n', '<C-j>', '<Cmd>call VSCodeNotify("workbench.action.navigateDown")<CR>')
    vim.keymap.set('n', '<C-k>', '<Cmd>call VSCodeNotify("workbench.action.navigateUp")<CR>')
    vim.keymap.set('n', '<C-l>', '<Cmd>call VSCodeNotify("workbench.action.navigateRight")<CR>')
	vim.keymap.set('n','za', '<Cmd>call VSCodeNotify("editor.fold")<CR>')
	vim.keymap.set('n','<leader>zm', '<Cmd>call VSCodeNotify("editor.foldAll")<CR>')
	vim.keymap.set('n','<leader>zr', '<Cmd>call VSCodeNotify("editor.unfoldAll")<CR>')

	vim.keymap.set('n','<leader>f1', '<Cmd>call VSCodeNotify("editor.foldLevel1")<CR>')
	vim.keymap.set('n','<leader>f2', '<Cmd>call VSCodeNotify("editor.foldLevel2")<CR>')
	vim.keymap.set('n','<leader>f3', '<Cmd>call VSCodeNotify("editor.foldLevel3")<CR>')
	vim.keymap.set('n','<leader>f4', '<Cmd>call VSCodeNotify("editor.foldLevel4")<CR>')
	vim.keymap.set('n', '<C-d>', '<Cmd>25j<CR>')
	vim.keymap.set('n', '<C-b>', '<Cmd>25k<CR>')
	-- nnoremap <C-w>h
-- xnoremap <C-w>h <Cmd>call VSCodeNotify('workbench.action.navigateLeft')<CR>
else
    require('lazy').setup(plugins, { dev = { path = '~/personal/plugin' } })
    require 'keymaps'
end
require 'conf'

ReloadGit = function()
    require('plenary.reload').reload_module 'git-auto-sync'
    require('git-auto-sync').setup {
        {
            '~/Documents/notes',
            auto_pull = true,
            auto_commit = true,
            auto_push = true,
            name = 'notes',
        },
    }
end
