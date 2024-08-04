return {
    {
        'kevinhwang91/nvim-ufo',
        dependencies = 'kevinhwang91/promise-async',
        event = 'BufReadPost', -- needed for folds to load properly
        keys = {
            {
                'zr',
                function()
                    require('ufo').openFoldsExceptKinds { 'comment' }
                end,
                desc = ' 󱃄 Open All Folds except comments',
            },
            {
                'zm',
                function()
                    require('ufo').closeAllFolds()
                end,
                desc = ' 󱃄 Close All Folds',
            },
            {
                'f1',
                function()
                    require('ufo').closeFoldsWith(1)
                end,
                desc = ' 󱃄 Close L1 Folds',
            },
            {
                'f2',
                function()
                    require('ufo').closeFoldsWith(2)
                end,
                desc = ' 󱃄 Close L2 Folds',
            },
            {
                'f3',
                function()
                    require('ufo').closeFoldsWith(3)
                end,
                desc = ' 󱃄 Close L3 Folds',
            },
            {
                'f4',
                function()
                    require('ufo').closeFoldsWith(4)
                end,
                desc = ' 󱃄 Close L4 Folds',
            },
        },
        config = function()
            vim.o.foldcolumn = '1' -- '0' is not bad
            vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
            vim.o.foldlevelstart = 99
            vim.o.foldenable = true
            require('ufo').setup {

                close_fold_kinds_for_ft = { default = { 'imports', 'comment' } },
                open_fold_hl_timeout = 500,
            }
        end,
    },
}
