return {
    {
        -- test
        -- Highlight, edit, and navigate code
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'nvim-treesitter/playground',
            'nvim-treesitter/nvim-treesitter-textobjects',
            'JoosepAlviste/nvim-ts-context-commentstring',
        },
        build = ':TSUpdate',
        config = function()
            require('nvim-treesitter.configs').setup {
                -- Add languages to be installed here that you want installed for treesitter
                ensure_installed = {
                    'norg',
                    'c_sharp',
                    'lua',
                    'rust',
                    'tsx',
                    'javascript',
                    'typescript',
                    'vimdoc',
                    'vim',
                    'bash',
                },
                -- playground = {
                --     query_linter = {
                --         enable = true,
                --         use_virtual_text = true,
                --         lint_events = { 'BufWrite', 'CursorHold' },
                --     },
                --     enable = true,
                --     disable = {},
                --     updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
                --     persist_queries = false, -- Whether the query persists across vim sessions
                --     keybindings = {
                --         toggle_query_editor = 'o',
                --         toggle_hl_groups = 'i',
                --         toggle_injected_languages = 't',
                --         toggle_anonymous_nodes = 'a',
                --         toggle_language_display = 'I',
                --         focus_language = 'f',
                --         unfocus_language = 'F',
                --         update = 'R',
                --         goto_node = '<cr>',
                --         show_help = '?',
                --     },
                -- },
                -- context_commentstring = {
                --     enable = true,
                -- },
                auto_install = true,
                highlight = { enable = true },
                indent = { enable = true },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = '<c-space>',
                        node_incremental = '<c-space>',
                        scope_incremental = '<c-s>',
                        node_decremental = '<M-space>',
                    },
                },

                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
                        keymaps = {
                            -- You can use the capture groups defined in textobjects.scm
                            ['aa'] = '@parameter.outer',
                            ['ia'] = '@parameter.inner',
                            ['af'] = '@function.outer',
                            ['if'] = '@function.inner',
                            ['ac'] = '@class.outer',
                            ['ic'] = '@class.inner',
                        },
                    },
                    move = {
                        enable = true,
                        set_jumps = true, -- whether to set jumps in the jumplist
                        goto_next_start = {
                            [']m'] = '@function.outer',
                            [']]'] = '@class.outer',
                        },
                        goto_next_end = {
                            [']M'] = '@function.outer',
                            [']['] = '@class.outer',
                        },
                        goto_previous_start = {
                            ['[m'] = '@function.outer',
                            ['[['] = '@class.outer',
                        },
                        goto_previous_end = {
                            ['[M'] = '@function.outer',
                            ['[]'] = '@class.outer',
                        },
                    },
                    swap = {
                        enable = true,
                        swap_next = {
                            ['<leader>si'] = '@parameter.inner',
                        },
                        swap_previous = {
                            ['<leader>so'] = '@parameter.inner',
                        },
                    },
                },
            }
        end,
    },
    {
        'jlcrochet/vim-razor',
    },
}
