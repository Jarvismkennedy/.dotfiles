local testies_cmd = function()
    local ft = vim.bo.filetype
    local cmd = ''
    if ft == 'elixir' then
        cmd = '! mix test'
    end
    if ft == 'c_sharp' then
        cmd = '! dotnet test'
    end
    return cmd
end

local run_testies = function()
    vim.cmd(testies_cmd())
end
local run_testies_on_file = function()
    vim.cmd(testies_cmd() .. ' %')
end

vim.keymap.set('n', '<leader>t', run_testies_on_file)
vim.keymap.set('n', '<leader>T', run_testies)
