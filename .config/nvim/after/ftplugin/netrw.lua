local items = {
    { short_name = 'apicontroller', name = 'API Controller' },
    { short_name = 'mvccontroller', name = 'MVC Controller' },
    { short_name = 'page', name = 'Razor Page' },
    { short_name = 'view', name = 'Razor View' },
    { short_name = 'razorcomponent', name = 'Razor Component' },
    { short_name = 'class', name = 'Class' },
    { short_name = 'interface', name = 'Interface' },
    { short_name = 'record', name = 'Record' },
    { short_name = 'struct', name = 'Struct' },
    { short_name = 'enum', name = 'Enum' },
}
local print_result = function(_, data, _)
    vim.print(data)
end
local function select_dotnet_new_option()
    vim.ui.select(items, {
        prompt = 'dotnet new...',
        format_item = function(item)
            return item.name
        end,
    }, function(choice)
        local dir = vim.b.netrw_curdir
        local short_name = choice.short_name

        vim.ui.input({ prompt = 'Name: ' }, function(input)
            local cmd = 'dotnet new ' .. short_name .. ' --name ' .. input
            vim.fn.jobstart(cmd, {
                cwd = dir,
                on_exit = function(_, code, _)
                    -- reload netrw
                    vim.cmd [[e!]]
                end,

                on_stdout = function(_, data, _)
                    vim.api.nvim_notify(table.concat(data), vim.log.levels.INFO, {})
                end,
                on_stderr = function(_, data, _)
                    vim.api.nvim_notify(table.concat(data), vim.log.levels.ERROR, {})
                end,
                stderr_buffered = true,
                stdout_buffered = true,
            })
        end)
    end)
end

vim.keymap.set('n', '#', select_dotnet_new_option, { buffer = true })
vim.api.nvim_buf_create_user_command(0, 'DotnetNew', function(args)
    if #args.fargs ~= 2 then
        vim.api.nvim_notify(
            'Invalid usage: Should be DotnetNew <object> <name>, e.g. DotnetNew class MyClass',
            vim.log.levels.ERROR,
            {}
        )
        return
    end
    local thing = args.fargs[1]
    local name = args.fargs[2]

    local dir = vim.b.netrw_curdir

    local cmd = 'dotnet new ' .. thing .. ' --name ' .. name
    vim.fn.jobstart(cmd, {
        cwd = dir,
        on_exit = function(_, _, _)
            -- reload netrw
            vim.cmd [[e!]]
        end,

        on_stdout = function(_, data, _)
            vim.api.nvim_notify(table.concat(data), vim.log.levels.INFO, {})
        end,
        on_stderr = function(_, data, _)
            vim.api.nvim_notify(table.concat(data), vim.log.levels.ERROR, {})
        end,
        stderr_buffered = true,
        stdout_buffered = true,
    })
end, { nargs = '+', desc = 'runs dotnet new {thing} --name {name}' })
