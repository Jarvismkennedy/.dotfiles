return {
    'nvim-lua/plenary.nvim',
    config = function()
        require('plenary.filetype').add_table {
            extension = {
                ['norg'] = 'norg',
            },
        }
    end,
}
