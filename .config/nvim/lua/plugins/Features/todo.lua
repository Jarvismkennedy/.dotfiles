return {
    'jarvismkennedy/todo.nvim',
    opts = {
		open_on_launch=true
	},
    lazy = false,
    dev = true,
    keys = {
        { '<leader>ts', '<cmd>Todo<cr>', desc = '[T]odo [S]how' },
        { '<leader>tc', '<cmd>Todo close<cr>', desc = '[T]odo [C]lose' },
    },
}
