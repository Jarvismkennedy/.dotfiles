local conf = { theme = 'ivy' }
return {
    'nvim-telescope/telescope.nvim',
    keys = {
        { '<leader>ff', '<cmd>Telescope find_files<CR>', desc = '[F]ind [F]iles' },
        { '<leader>ee', '<cmd>Telescope find_files<CR>', desc = '[F]ind [F]iles' },
        { '<leader>?', '<cmd>Telescope oldfiles<CR>', desc = '[?] Find recently opened files' },
        { '<leader><space>', '<cmd>Telescope buffers<CR>', desc = '[ ] Find existing buffers' },
        { '<leader>/', '<cmd>Telescope current_buffer_fuzzy_find<CR>', desc = '[/] search buffer' },

        {
            '<C-f>',
            function()
                require('telescope.builtin').grep_string { search = vim.fn.input 'GREP > ' }
            end,
            desc = 'Grep string',
        },
        { '<leader>gf', '<cmd>Telescope git_files<CR>', desc = 'Search [G]it [F]iles' },
        { '<leader>sh', '<cmd>Telescope help_tags<CR>', desc = '[S]earch [H]elp' },
        { '<leader>sw', '<cmd>Telescope grep_string<CR>', desc = '[S]earch current [W]ord' },
        { '<leader>sg', '<cmd>Telescope live_grep<CR>', desc = '[S]earch by [G]rep' },
        { '<leader>sd', '<cmd>Telescope diagnostics<CR>', desc = '[S]earch [D]iagnostics' },
    },
    dependencies = {
        'nvim-lua/plenary.nvim',
        -- Fuzzy Finder Algorithm which requires local dependencies to be built.
        -- Only load if `make` is available. Make sure you have the system
        -- requirements installed.
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            -- NOTE: If you are having trouble with this installation,
            --       refer to the README for telescope-fzf-native for more instructions.
            build = 'make',
            cond = function()
                return vim.fn.executable 'make' == 1
            end,
        },
        'nvim-neorg/neorg',
        'nvim-lua/plenary.nvim',
    },
    opts = {
        pickers = {
            find_files = conf,
            buffers = conf,
            oldfiles = conf,
            current_buffer_fuzzy_find = conf,
            git_files = conf,
            help_tags = conf,
            grep_string = conf,
            live_grep = conf,
            diagnostics = conf,
        },
    },
}
