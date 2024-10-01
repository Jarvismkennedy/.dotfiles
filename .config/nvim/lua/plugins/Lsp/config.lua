-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
--
--  If you want to override the default filetypes that your language server will attach to you can
--  define the property 'filetypes' to the map in question.
local servers = {
    -- clangd = {},
    -- omnisharp={},
    gopls = {},
    templ = {},
    zls = {},
    -- pyright = {},
    rust_analyzer = {},
    ts_ls = {},
    emmet_ls = {},
    cssls = {},
    bashls = {},
    html = { filetypes = { 'html', 'twig', 'hbs', 'razor' } },
    tailwindcss = { filetypes = { 'html', 'typescriptreact', 'javascriptreact', 'razor' } },
    lua_ls = {
        Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
            diagnostics = {
                globals = { 'vim' },
            },
        },
    },
}
local on_attach = require('plugins.Lsp.utils').on_attach

return {
    {
        'williamboman/mason-lspconfig.nvim',
        config = function()
            local capabilities = vim.tbl_deep_extend(
                'force',
                vim.lsp.protocol.make_client_capabilities(),
                require('cmp_nvim_lsp').default_capabilities()
            )
            -- for ufo folding
            capabilities.textDocument.foldingRange = {
                dynamicRegistration = false,
                lineFoldingOnly = true,
            }

            -- Ensure the servers above are installed
            local mason_lspconfig = require 'mason-lspconfig'

            mason_lspconfig.setup {
                ensure_installed = vim.tbl_keys(servers),
            }

            mason_lspconfig.setup_handlers {
                function(server_name)
                    require('lspconfig')[server_name].setup {
                        capabilities = capabilities,
                        on_attach = on_attach,
                        settings = servers[server_name],
                        filetypes = (servers[server_name] or {}).filetypes,
                    }
                end,
            }

            require('lspconfig').gleam.setup {}
        end,
    },
    -- {
    --     'jmederosalvarado/roslyn.nvim',
    --     config = function()
    --         local capabilities = vim.tbl_deep_extend(
    --             'force',
    --             vim.lsp.protocol.make_client_capabilities(),
    --             require('cmp_nvim_lsp').default_capabilities()
    --         )
    --         require('roslyn').setup {
    --             on_attach = on_attach, -- required
    --             capabilities = capabilities, -- required
    --         }
    --     end,
    --     dependencies = { 'neovim/nvim-lspconfig' },
    -- },
    -- {
    --     'tris203/rzls.nvim',
    -- },
    -- {
    --     'jarvismkennedy/razor.nvim',
    --     config = function()
    --         require('razor').setup()
    --     end,
    --     dev = true,
    -- },
}
