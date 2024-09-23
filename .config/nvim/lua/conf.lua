vim.opt.guicursor = ''
vim.opt.pumblend = 0
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.colorcolumn = '120'
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.signcolumn = 'yes'
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.laststatus = 3
vim.api.nvim_set_hl(0, 'WinSeparator', { bg = 'None' })
vim.diagnostic.config {
    underline = true,
    update_in_insert = false,
    virtual_text = {
        spacing = 4,
        source = 'if_many',
        prefix = '●',
        -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
        -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
        -- prefix = "icons",
    },
    severity_sort = true,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = ' ',
            [vim.diagnostic.severity.WARN] = ' ',
            [vim.diagnostic.severity.HINT] = '',
            [vim.diagnostic.severity.INFO] = ' ',
        },
    },
}
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--vim.o.clipboard = "unnamedplus"

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})

vim.api.nvim_create_autocmd('CursorHold', {
    buffer = bufnr,
    callback = function()
        local opts = {
            focusable = false,
            close_events = { 'BufLeave', 'CursorMoved', 'InsertEnter', 'FocusLost' },
            border = 'rounded',
            source = 'always',
            prefix = ' ',
            scope = 'cursor',
        }
        vim.diagnostic.open_float(nil, opts)
    end,
})

-- vim.api.nvim_create_autocmd('User', {
--    pattern = 'TelescopePreviewerLoaded',
--     callback = function(args)
--         vim.print(args)
--     end,
-- })

vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
-- vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
vim.api.nvim_set_hl(0, 'NormalNC', { bg = 'none' })

-- global functions
PreserveCursorPosition = function(arguments)
    local arguments = string.format('keepjumps keeppatterns execute %q', arguments)
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    vim.api.nvim_command(arguments)
    local lastline = vim.fn.line '$'
    if line > lastline then
        line = lastline
    end
    vim.api.nvim_win_set_cursor(0, { line, col })
end
