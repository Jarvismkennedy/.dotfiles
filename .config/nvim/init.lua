vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
if vim.g.vscode then
    require 'vs-code'
else
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
    require('lazy').setup(plugins, { dev = { path = '~/personal/plugin' } })
    require 'keymaps'
end

require 'conf'
require 'custom.split-notes'
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


