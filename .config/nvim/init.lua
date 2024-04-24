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
require('lazy').setup(plugins, { dev = { path = '~/personal/plugin' } })

require 'keymaps'
require 'conf'

ReloadGit = function()
    require('plenary.reload').reload_module 'git-auto-sync'
    require('git-auto-sync').setup {
        {
            '~/Documents/notes',
            auto_pull = true,
            auto_commit = true,
            auto_push = true,
			name = "notes"
        },
    }
end

ReloadNeorg = function()
    print 'reloading neorg'
    local reload = require('plenary.reload').reload_module
    reload 'neorg'
    reload 'neorg.modules.core.utils'
    reload 'neorg.modules.core.integrations.roam.module'
    reload 'neorg.modules.core.integrations.roam.capture.module'
    require('neorg').setup {
        load = {
            ['core.defaults'] = {}, -- Loads default behaviour
            ['core.concealer'] = {
                config = {
                    icon_preset = 'basic',
                },
            }, -- Adds pretty icons to your documents
            ['core.export'] = {},
            ['core.dirman'] = { -- Manages Neorg workspaces
                config = {
                    workspaces = {
                        work = '~/Documents/notes/work',
                        roam = '~/Documents/notes/roam',
                    },
                    default_workspace = 'roam',
                },
            },
            ['core.looking-glass'] = {},
            ['core.integrations.roam'] = {
                config = {
                    capture_templates = {
                        {
                            name = 'default',
                            lines = { '', '' },
                        },
                        {
                            name = 'New Class Note',
                            file = '${title}_${date}',
                            lines = { '', '* ${heading1}', '' },
                        },
                    },
                },
            },
        },
    }
end
