return {
    {
        'numToStr/Comment.nvim',
        config = function()
            ---@diagnostic disable-next-line: missing-fields
            require('Comment').setup {
                pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
            }
        end,
        lazy = false,
    },
    {
        'folke/todo-comments.nvim',
        lazy = false,
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
        },
        keys = {
            { '<leader>xt', '<cmd>Trouble todo toggle<cr>', desc = 'Todos' },
        },
    },
}
