return {
    'folke/trouble.nvim',
    opts = {
        modes = {
            diagnostics = {
                filter = function(items)
                    return vim.tbl_filter(function(item)
                        return not string.match(item.basename, [[%__virtual.cs$]])
                    end, items)
                end,
            },
        },
    }, -- for default options, refer to the configuration section for custom setup.
	lazy=false,
    keys = {

        {
            '<leader>xx',
            '<cmd>Trouble diagnostics toggle<cr>',
            desc = 'Diagnostics (Trouble)',
        },
        { '<leader>xn', '<cmd>Trouble diagnostics next<cr>', desc = 'Diagnostics next' },
        { '<leader>xp', '<cmd>Trouble diagnostics previous<cr>', desc = 'Diagnostics previous' },
        {
            '<leader>xc',
            '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
            desc = 'Buffer Diagnostics (Trouble)',
        },
        {
            '<leader>cs',
            '<cmd>Trouble symbols toggle focus=false win.position=left<cr>',
            desc = 'Symbols (Trouble)',
        },
        {
            '<leader>cl',
            '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
            desc = 'LSP Definitions / references / ... (Trouble)',
        },
        {
            '<leader>xL',
            '<cmd>Trouble loclist toggle<cr>',
            desc = 'Location List (Trouble)',
        },
        {
            '<leader>xQ',
            '<cmd>Trouble qflist toggle<cr>',
            desc = 'Quickfix List (Trouble)',
        },
    },
}
