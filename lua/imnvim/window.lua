local search = require('imnvim.search').search
local process = require('imnvim.search').process
local api = vim.api
local vim = vim
local window = {input = '', result = {}}

function window:open_window()
    buf = api.nvim_create_buf(false, true)
    api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')
    api.nvim_buf_set_option(buf, 'filetype', 'imnvim')
    self.buf = buf

    local opts = {
        style = "minimal",
        relative = "cursor",
        width = 1,
        height = 1,
        row = 0,
        col = 0
    }

    -- 进入新的窗口
    self.win = api.nvim_open_win(buf, false, opts)
end

function window:update_view()
    local line, line_width, header_width = process(self.result)
    -- 更改窗口宽度
    local opts = {
        width = line_width,
    }
    api.nvim_win_set_config(self.win, opts)

    api.nvim_buf_set_option(self.buf, 'modifiable', true)

    api.nvim_buf_set_lines(self.buf, 0, -1, false, {line})
    api.nvim_buf_add_highlight(self.buf, -1, 'Pmenu', 0, 0, -1)
    api.nvim_buf_add_highlight(self.buf, -1, 'PmenuSel', 0, 0, header_width)

    api.nvim_buf_set_option(self.buf, 'modifiable', false)
end

function window:close_window()
    api.nvim_win_close(self.win, true)
end


function window:delete()
    self.input = string.sub(self.input, 1, -2)
    self.result = search(self.input)
    self:update_view()
end

function window:add_key(key)
    self.input = self.input .. key
    self.result = search(self.input)
    self:update_view()
end

function window:new(o)
    o = o or {}
    self.__index = self
    setmetatable(o, self)
    return o
end

return window
