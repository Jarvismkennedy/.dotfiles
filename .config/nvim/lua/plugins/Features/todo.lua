return {
    'jarvismkennedy/todo.nvim',
    config = function()
        local config = { todos = {
            work = '~/work',
        } }
        require('todo').setup(config)
    end,
    dev = true,
    keys = {
        { '<leader>ts', '<cmd>Todo<cr>', desc = '[T]odo [S]how' },
        { '<leader>tc', '<cmd>Todo close<cr>', desc = '[T]odo [C]lose' },
    },
}
