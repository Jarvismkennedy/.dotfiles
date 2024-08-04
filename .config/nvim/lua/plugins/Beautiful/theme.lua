-- you need to make your own colorscheme halfway between onedark warm and tomorrow-night..
-- or you need to extend base16 to fix the weird color issues with transparent.
return {
    one_dark = {
        'navarasu/onedark.nvim',
        priority = 1000,
        config = function()
            require('onedark').setup {
                style = 'warm',
                transparent = true,
            }
            require('onedark').load()
        end,
    },
    rosepine = { 'rose-pine/neovim', name = 'rose-pine' },
    vscode = {
        'rockyzhang24/arctic.nvim',
        dependencies = { 'rktjmp/lush.nvim' },
        name = 'arctic',
        branch = 'v2',
        priority = 1000,
        config = function()
            vim.cmd 'colorscheme arctic'
        end,
    },
}
