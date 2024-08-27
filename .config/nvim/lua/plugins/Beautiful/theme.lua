-- you need to make your own colorscheme halfway between onedark warm and tomorrow-night..
-- or you need to extend base16 to fix the weird color issues with transparent.
return {
    {
        'navarasu/onedark.nvim',
        priority = 1000,
        config = function()
            -- require('onedark').setup {
            --     style = 'warm',
            --     transparent = true,
            -- }
            -- require('onedark').load()
        end,
    },
    {
        'catppuccin/nvim',
        name = 'catppuccin',
        priority = 1000,
        config = function()
            -- vim.cmd 'colorscheme catppuccin-mocha'
        end,
    },
    {
        'folke/tokyonight.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            -- vim.cmd 'colorscheme tokyonight'
        end,
    },
    {
        'rose-pine/neovim',
        name = 'rose-pine',
        config = function()
            require('rose-pine').setup {
                variant = 'moon',
                extend_background_behind_borders = false,
                styles = {
                    bold = true,
                    italic = true,
                    transparency = true,
                },
            }
            vim.cmd 'colorscheme rose-pine'
        end,
    },
    {
        'rockyzhang24/arctic.nvim',
        dependencies = { 'rktjmp/lush.nvim' },
        name = 'arctic',
        branch = 'v2',
        priority = 1000,
        config = function()
            -- vim.cmd 'colorscheme arctic'
        end,
    },
}
