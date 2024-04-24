return {
    'nvim-neorg/neorg',
    build = ':Neorg sync-parsers',
    opts = {
        load = {
            ['core.defaults'] = {}, -- Loads default behaviour
            ['core.concealer'] = {
                config = {
                    icon_preset = 'varied',
                },
            }, -- Adds pretty icons to your documents
            ['core.presenter'] = { config = {
                zen_mode = 'zen-mode',
            } },
            ['core.summary'] = {},
            ['core.export'] = {},
            ['core.dirman'] = { -- Manages Neorg workspaces
                config = {
                    workspaces = {
                        work = '~/Documents/notes/work',
                        roam = '~/Documents/notes/roam',
                        todo = '~/Documents/notes/todo',
                    },
                    default_workspace = 'roam',
                },
            },
            ['core.integrations.roam'] = {
                config = {
                    keymaps = {
                        select_prompt = '<C-Space>',
                    },
                },
            },
        },
    },
    dependencies = {
        'Jarvismkennedy/neorg-roam.nvim',
        'kkharji/sqlite.lua',
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope.nvim',
    },
    config = function(_, opts)
        require('neorg').setup(opts)
        local neorg_group = vim.api.nvim_create_augroup('NeorgAutoFmt', { clear = true })
        vim.api.nvim_create_autocmd('BufWritePre', {
            callback = function()
                PreserveCursorPosition 'normal! gg=G'
            end,
            group = neorg_group,
            pattern = '*.norg',
        })
    end,
}
