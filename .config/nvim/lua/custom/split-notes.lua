local win = nil
local buf = nil

local scratch = function()
    if buf == nil then
        buf = vim.api.nvim_create_buf(true, true)
        vim.api.nvim_set_option_value('filetype', 'markdown', { buf = buf })
        vim.api.nvim_buf_set_lines(buf, 0, 1, false, { '# Scratch buffer' })

        local group = vim.api.nvim_create_augroup('scratchGroup', { clear = true })

        vim.api.nvim_create_autocmd('BufHidden', {
            callback = function()
                vim.print 'killing'
                vim.api.nvim_win_close(0, false)
                win = nil
            end,
            group = group,
            buffer = buf,
        })
    end
    if win == nil then
        vim.cmd '50vsplit'
        win = vim.api.nvim_get_current_win()
        vim.api.nvim_win_set_buf(win, buf)
    else
        vim.api.nvim_win_close(win, false)
        win = nil
    end
end

vim.keymap.set('n', '<leader>e', scratch)
