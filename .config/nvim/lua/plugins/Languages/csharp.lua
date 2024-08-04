-- csharp specific stuff
return {
    'iabdelkareem/csharp.nvim',
    dependencies = {
        'williamboman/mason.nvim', -- Required, automatically installs omnisharp
        'mfussenegger/nvim-dap',
        'Tastyep/structlog.nvim', -- Optional, but highly recommended for debugging
    },
    config = function()
        vim.print 'setting up csharp'
        require('csharp').setup {
            -- Sets if you want to use roslyn as your LSP
            lsp = {
                omnisharp = { enabled = false },
                roslyn = {
                    -- When set to true, csharp.nvim will launch roslyn automatically.
                    enable = true,
                    -- Path to the roslyn LSP see 'Roslyn LSP Specific Prerequisites' above.
                    cmd_path = '/Users/jarviskennedy/Library/nvim/roslyn/Microsoft.CodeAnalysis.LanguageServer.dll',
                },
                capabilities = vim.tbl_deep_extend(
                    'force',
                    vim.lsp.protocol.make_client_capabilities(),
                    require('cmp_nvim_lsp').default_capabilities()
                ),
                on_attach = require('plugins.Lsp.utils').on_attach,
            },
        }
    end,
}
