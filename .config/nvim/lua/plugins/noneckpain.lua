local config = '/home/jarvisk/.config/'
local work = '/home/jarvisk/work/'
local personal = '/home/jarvisk/personal/'

local todo_locations = {
    [config .. 'nvim'] = 'config/nvim',
    [config .. 'home-manager'] = 'config/home-manager',
    [work .. 'SRPDV8/SRPDV8'] = 'work/srp',
    [work .. 'dv8identity'] = 'work/identity',
    [personal .. 'plugin/neorg-roam.nvim'] = 'plugin/neorg-roam',
    [personal .. 'plugin/git-auto-sync.nvim'] = 'plugin/git-auto-sync',
}
local function get_todo_location(cwd)
    if todo_locations[cwd] == nil then
        return 'default_todo'
    end
    return todo_locations[cwd]
end

return {
    'shortcuts/no-neck-pain.nvim',
    lazy = false,
    config = function(_, opts)
        for _, v in pairs(todo_locations) do
            os.execute('mkdir -p ~/Documents/notes/todo/' .. v)
        end
        require('no-neck-pain').setup(opts)
        -- local todo_group = vim.api.nvim_create_augroup('TodoAutoSave', { clear = true })
        -- vim.api.nvim_create_autocmd('InsertLeave', {
        --     callback = function()
        --         vim.cmd [[write]]
        --     end,
        --     group = todo_group,
        --     pattern = 'todo-left.norg',
        -- })
    end,
    opts = {
        autocmds = {
            enableOnVimEnter = true,
        },
        buffers = {
            right = { enabled = false },
            scratchPad = {
                enabled = true,
                fileName = 'todo',
                location = '~/Documents/notes/todo/',
            },
            bo = {
                filetype = 'markdown',
            },
        },
    },
    keys = {
        { '<leader>n', '<cmd>NoNeckPain<cr>', desc = '[n]o [n]eck pain' },
    },
}
