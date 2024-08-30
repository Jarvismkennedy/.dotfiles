local prettier_filetypes =
    { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'html', 'css', 'json', 'razor' }

local get_filetype = function()
    local util = require 'formatter.util'
    local ft = {
        lua = {
            -- "formatter.filetypes.lua" defines default configurations for the
            -- "lua" filetype
            function()
                return {
                    exe = 'stylua',
                    args = {
                        '--config-path',
                        '~/.config/nvim/formatter_configs/.stylua.toml',
                        '--search-parent-directories',
                        '--stdin-filepath',
                        util.escape_path(util.get_current_buffer_file_path()),
                        '--',
                        '-',
                    },
                    stdin = true,
                }
            end,
        },
        cs = {
            function()
                return {
                    exe = 'dotnet',
                    args = {
                        'csharpier',
                    },
                    stdin = true,
                }
            end,
        },
        elixir = {
            vim.lsp.buf.format,
        },

        sh = {
            require('formatter.filetypes.sh').shfmt,
        },
        rust = {
            require('formatter.filetypes.rust').rustfmt,
        },
        -- Use the special "*" filetype for defining formatter configurations on
        -- any filetype
        ['*'] = {
            -- "formatter.filetypes.any" defines default configurations for any
            -- filetype
            require('formatter.filetypes.any').remove_trailing_whitespace,
        },
    }

    for _, n in ipairs(prettier_filetypes) do
        ft[n] = {
            function()
                return {
                    exe = 'prettier',
                    args = {
                        '--stdin-filepath',
                        util.escape_path(util.get_current_buffer_file_path()),
                        '--config',
                        '~/.config/nvim/formatter_configs/.prettierrc',
                        -- '--config-precedence',
                        -- 'prefer-file',
                    },
                    stdin = true,
                    try_node_modules = true,
                }
            end,
        }
    end
    return ft
end

return {
    'mhartington/formatter.nvim',
    config = function()
        -- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
        require('formatter').setup {
            -- Enable or disable logging
            logging = true,
            -- Set the log level
            log_level = vim.log.levels.WARN,
            -- All formatter configurations are opt-in
            filetype = get_filetype(),
        }
    end,
    keys = {
        { '<leader>fw', '<cmd>Format<cr>', desc = '[C]ode [F]ormat' },
    },
}
