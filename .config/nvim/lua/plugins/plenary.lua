return {
    'nvim-lua/plenary.nvim',
    config = function()
        vim.filetype.add {
            extension = {
                ['razor'] = 'razor',
                ['cshtml'] = 'razor',
            },
        }
    end,
}
