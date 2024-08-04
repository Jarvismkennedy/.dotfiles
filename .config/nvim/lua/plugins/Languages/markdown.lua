return {
    {
        'lukas-reineke/headlines.nvim',
        dependencies = 'nvim-treesitter/nvim-treesitter',
        opts = {
            markdown = {
                fat_headlines = false,
                -- headline_highlights = { "Headline1", "Headline2"}
                -- headline_highlights = false
            },
        },
        -- markdown highligthing and concealment
        {
            'ixru/nvim-markdown',
        },
        -- preview md files
        {
            'iamcco/markdown-preview.nvim',
            cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
            build = 'cd app && yarn install',
            init = function()
                vim.g.mkdp_filetypes = { 'markdown' }
            end,
            ft = { 'markdown' },
        },
        -- pretty printing tables
        {
            'dhruvasagar/vim-table-mode',
        },
    },
}
