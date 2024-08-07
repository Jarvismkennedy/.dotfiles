return {
    'folke/zen-mode.nvim',
    opts = {
        window = {
            backdrop = 0.85, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
            -- height and width can be:
            -- * an absolute number of cells when > 1
            -- * a percentage of the width / height of the editor when <= 1
            -- * a function that returns the width or the height
            width = 130, -- width of the Zen window
            height = 1, -- height of the Zen window
            -- by default, no options are changed for the Zen window
            -- uncomment any of the options below, or add other vim.wo options you want to apply
            options = {
                -- signcolumn = "no", -- disable signcolumn
                number = true, -- disable number column
                relativenumber = true, -- disable relative numbers
                cursorline = true, -- disable cursorline
                cursorcolumn = false, -- disable cursor column
                -- foldcolumn = "0", -- disable fold column
                -- list = false, -- disable whitespace characters
            },
        },
        -- callback where you can add custom code when the Zen window opens
        on_open = function(win) end,
        -- callback where you can add custom code when the Zen window closes
        on_close = function() end,
    },
    keys = {
        { '<leader>zn', '<cmd>ZenMode<CR>', desc = 'Replace no neck pain' },
    },
    lazy = false,
}
