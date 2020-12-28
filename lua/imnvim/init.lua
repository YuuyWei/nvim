function _G.dump(object)
    print(vim.inspect(object))
end

local search = require('imnvim.match')

local api = vim.api
local buf, win
local position = 0
local results
local input = 'a.'

local function process(input)
    results = search(input)
    local line_width = 0
    local line = ''
    for i, v in ipairs(results) do
        line_width = line_width + v.width + 4
        line = string.format('%s %d.%s ', line, i, v.string)
    end
    return line, line_width ,#results[1].string + 4
end

local function open_window(input)
    local line, line_width, header_width = process(input)

    buf = api.nvim_create_buf(false, true)

    api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')
    api.nvim_buf_set_option(buf, 'filetype', 'imnvim')

    local win_height = 1
    dump(line_width)
    local win_width = line_width
    local row = 1
    local col = 5

    local opts = {
        style = "minimal",
        relative = "cursor",
        width = win_width,
        height = win_height,
        row = row,
        col = col
    }

    -- 进入新的窗口
    win = api.nvim_open_win(buf, true, opts)

    -- 展示搜索结果
    api.nvim_buf_set_lines(buf, 0, -1, false, {line})
    api.nvim_buf_add_highlight(buf, -1, 'Pmenu', 0, 0, -1)
    api.nvim_buf_add_highlight(buf, -1, 'PmenuSel', 0, 0, header_width)
end

local function update_view(input)
    local line, line_width, header_width = process(input)
    -- 更改窗口宽度
    api.nvim_win_set_width(win, line_width)

    api.nvim_buf_set_option(buf, 'modifiable', true)

    api.nvim_buf_set_lines(buf, 0, -1, false, {line})
    api.nvim_buf_add_highlight(buf, -1, 'Pmenu', 0, 0, -1)
    api.nvim_buf_add_highlight(buf, -1, 'PmenuSel', 0, 0, header_width)

    api.nvim_buf_set_option(buf, 'modifiable', false)
end

local function close_window()
    api.nvim_win_close(win, true)
end

local function open_file()
    local str = api.nvim_get_current_line()
    close_window()
    api.nvim_command('edit '..str)
end

local function move_cursor()
    local new_pos = math.max(4, api.nvim_win_get_cursor(win)[1] - 1)
    api.nvim_win_set_cursor(win, {new_pos, 0})
end

local function set_mappings()
    local mappings = {
        ['['] = 'update_view(-1)',
        [']'] = 'update_view(1)',
        ['<cr>'] = 'open_file()',
        h = 'update_view(-1)',
        l = 'update_view(1)',
        q = 'close_window()',
        k = 'move_cursor()'
    }

    for k,v in pairs(mappings) do
        api.nvim_buf_set_keymap(buf, 'n', k, ':lua require"imnvim".'..v..'<cr>', {
            nowait = true, noremap = true, silent = true
        })
    end
    local other_chars = {
        'a', 'b', 'c', 'd', 'e', 'f', 'g', 'i', 'n', 'o', 'p', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'
    }
    for k,v in ipairs(other_chars) do
        api.nvim_buf_set_keymap(buf, 'n', v, '', { nowait = true, noremap = true, silent = true })
        api.nvim_buf_set_keymap(buf, 'n', v:upper(), '', { nowait = true, noremap = true, silent = true })
        api.nvim_buf_set_keymap(buf, 'n',  '<c-'..v..'>', '', { nowait = true, noremap = true, silent = true })
    end
end

local function imnvim()
    position = 0
    open_window(input)
    -- set_mappings()
    update_view(input)
    -- api.nvim_win_set_cursor(win, {4, 0})
end

imnvim()

return {
    imnvim = imnvim,
    open_window = open_window,
    update_view = update_view,
    move_cursor = move_cursor,
    close_window = close_window
}

