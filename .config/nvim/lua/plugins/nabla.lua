return {
    'jbyuki/nabla.nvim',
    config = function()
        vim.keymap.set('n', '<leader>lp', ":lua require('nabla').popup()<CR>")
        vim.keymap.set('n', '<leader>tl', ":lua require('nabla').toggle_virt()<CR>")
    end,
}
