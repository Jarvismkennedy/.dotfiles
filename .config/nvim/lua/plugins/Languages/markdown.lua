return {
    -- {
    --     'lukas-reineke/headlines.nvim',
    --     dependencies = 'nvim-treesitter/nvim-treesitter',
    --     opts = {
    --         markdown = {
    --             fat_headlines = false,
    --             -- headline_highlights = { "Headline1", "Headline2"}
    --             -- headline_highlights = false
    --         },
    --     },
    -- },
    {
        'MeanderingProgrammer/render-markdown.nvim',
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
        ---@module 'render-markdown'
        ---@type render.md.UserConfig
        opts = {},
        lazy = false,
    },
    -- pretty printing tables
    {
        'dhruvasagar/vim-table-mode',
    },
}
