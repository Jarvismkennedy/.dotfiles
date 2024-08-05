local on_attach = require('plugins.Lsp.utils').on_attach

local roslyn_path = vim.fn.stdpath 'data' .. '/roslyn/Microsoft.CodeAnalysis.LanguageServer.dll'

-- csharp specific stuff
return {

    'iabdelkareem/csharp.nvim',
    dependencies = {
        'williamboman/mason.nvim', -- Required, automatically installs omnisharp
        'mfussenegger/nvim-dap',
        'Tastyep/structlog.nvim', -- Optional, but highly recommended for debugging
    },
    config = function()
        local capabilities = vim.tbl_deep_extend(
            'force',
            vim.lsp.protocol.make_client_capabilities(),
            require('cmp_nvim_lsp').default_capabilities()
        )
        capabilities.textDocument.foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true,
        }
        require('csharp').setup {
            -- Sets if you want to use roslyn as your LSP
            lsp = {
                omnisharp = { enabled = false, enable_analyzers_support = true },
                roslyn = {
                    -- When set to true, csharp.nvim will launch roslyn automatically.
                    enable = true,
                    -- Path to the roslyn LSP see 'Roslyn LSP Specific Prerequisites' above.
                    cmd_path = roslyn_path,
                },
                capabilities = capabilities,
                on_attach = on_attach,
            },
        }
    end,
}
