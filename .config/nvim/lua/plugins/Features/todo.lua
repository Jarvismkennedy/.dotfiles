return {
    'jarvismkennedy/todo.nvim',
    config = function()
        local config = {
            -- NOTE: save todos at ~/todo for use with git-auto-sync
            data_path = '~/todos',
            -- NOTE: create a separate todos for work directory
            todos = {
                work = { dir = { '~/work', '~/Documents/DV8EnergyInc' } },
            },
        }
        require('todo').setup(config)
    end,
    lazy = false,
    dev = true,
    keys = {
        { '<leader>ts', '<cmd>Todo<cr>', desc = '[T]odo [S]how' },
        { '<leader>tc', '<cmd>Todo close<cr>', desc = '[T]odo [C]lose' },
    },
}
