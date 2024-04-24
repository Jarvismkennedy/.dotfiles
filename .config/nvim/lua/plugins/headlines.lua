vim.cmd [[highlight Headline1 guibg=#1e2718]]
vim.cmd [[highlight Headline2 guibg=#21262d]]
vim.cmd [[highlight CodeBlock guibg=#1c1c1c]]
vim.cmd [[highlight Dash guibg=#D19A66 gui=bold]]

return {
    'lukas-reineke/headlines.nvim',
    dependencies = 'nvim-treesitter/nvim-treesitter',
	opts = {
		markdown = {
			-- fat_headlines = false,
			-- headline_highlights = {"Headline1", "Headline2"}
			-- headline_highlights = false
		}
	}
}
