return {
    {
        'mfussenegger/nvim-dap',
        config = function()
            local dap = require 'dap'

            dap.adapters.coreclr = {
                type = 'executable',
                command = 'netcoredbg',
                args = { '--interpreter=vscode' },
            }

            dap.configurations.cs = {
                {
                    type = 'coreclr',
                    name = 'launch - netcoredbg',
                    request = 'launch',
                    program = function()
                        return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
                    end,
                    -- args = { 'SqliteMetrics' },
                },
            }
            vim.keymap.set('n', '<space>b', dap.toggle_breakpoint)
            vim.keymap.set('n', '<space>cb', function()
                dap.set_breakpoint(vim.fn.input 'condition: ')
            end)
            vim.keymap.set('n', '<space>gb', dap.run_to_cursor)

            vim.keymap.set('n', '<F1>', dap.continue)
            vim.keymap.set('n', '<F2>', dap.step_into)
            vim.keymap.set('n', '<F3>', dap.step_over)
            vim.keymap.set('n', '<F4>', dap.step_out)
            vim.keymap.set('n', '<F5>', dap.step_back)

            vim.keymap.set('n', '<F6>', dap.set_exception_breakpoints)
            vim.keymap.set('n', '<F10>', dap.restart)
        end,
    },
    {
        'rcarriga/nvim-dap-ui',
        dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio', 'theHamsta/nvim-dap-virtual-text' },
        config = function()
            local dap, ui = require 'dap', require 'dapui'

            require('nvim-dap-virtual-text').setup {
                -- This just tries to mitigate the chance that I leak tokens here. Probably won't stop it from happening...
                display_callback = function(variable)
                    -- local name = string.lower(variable.name)
                    -- local value = string.lower(variable.value)
                    -- if name:match 'secret' or name:match 'api' or value:match 'secret' or value:match 'api' then
                    --     return '*****'
                    -- end

                    if #variable.value > 15 then
                        return ' ' .. string.sub(variable.value, 1, 15) .. '... '
                    end

                    return ' ' .. variable.value
                end,
            }

            ui.setup {}

            -- Eval var under cursor
            vim.keymap.set('n', '<space>?', function()
                require('dapui').eval(nil, { enter = true })
            end)

            dap.listeners.before.attach.dapui_config = function()
                ui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                ui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                ui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                ui.close()
            end
        end,
    },
}
