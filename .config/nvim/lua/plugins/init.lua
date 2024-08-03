local plugins = {
    require 'plugins.cmp',
    require 'plugins.comment',
    require 'plugins.formatter',
    require 'plugins.git',
    require 'plugins.git_auto_sync',
    require 'plugins.gitsigns',
    require 'plugins.harpoon',
    -- require 'plugins.indent',
    require 'plugins.lsp',
    require 'plugins.lualine',
    require 'plugins.mason_lspconfig',
    -- fold needs to come after mason_lspconfig
	-- fold is currently broken with lsp...
    require 'plugins.fold',
    require 'plugins.nabla',
    require 'plugins.neodev',
    -- require 'plugins.neorg',
    -- require 'plugins.neorg_roam',
    require 'plugins.plenary',
	require 'plugins.trouble',
    require 'plugins.tablemode',
    require 'plugins.telescope',
    require 'plugins.theme'.one_dark,
    require 'plugins.treesitter',
    require 'plugins.zenmode',
	-- require 'plugins.noneckpain',
	require 'plugins.mdprev',
	require 'plugins.md',
	require 'plugins.headlines',
	require 'plugins.dap',
	require 'plugins.dotnet.razor',
	require 'plugins.webdevicons',
	require 'plugins.neotree'
}

return plugins
