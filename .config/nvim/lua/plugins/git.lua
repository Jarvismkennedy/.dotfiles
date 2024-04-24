return { 
	"kdheepak/lazygit.nvim",
	dependencies = { 
		"nvim-lua/plenary.nvim",
	},
	keys = {{"<leader>gg", "<cmd>LazyGit<CR>", desc = "Lazy git"}},
	lazy = true,
	cmd = { "LazyGit" }
}
