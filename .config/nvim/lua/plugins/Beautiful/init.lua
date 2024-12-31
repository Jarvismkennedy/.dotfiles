return {
    require 'plugins.Beautiful.comment',
    require 'plugins.Beautiful.fold',
    require 'plugins.Beautiful.formatter',
    require 'plugins.Beautiful.indent',
    require 'plugins.Beautiful.lualine',
    require 'plugins.Beautiful.theme',
    require 'plugins.Beautiful.treesitter',
    require 'plugins.Beautiful.webdevicons',
    {
        'tjdevries/colorbuddy.nvim',
    },
    { 'roobert/tailwindcss-colorizer-cmp.nvim', opts = {} },
}
