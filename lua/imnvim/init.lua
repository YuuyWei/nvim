function _G.dump(object)
  print(vim.inspect(object))
end

local api = vim.api
local nr2char = vim.fn.nr2char
local getchar = vim.fn.getchar
local vim = vim
local window = require('imnvim.window')
local Alphabet = {
  'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o',
  'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'
}

local function check_equality(key1, key2)
  if vim.fn.char2nr(key1) == vim.fn.char2nr(key2) then
    return true
  end
end

local function is_in_array(key, t)
  for _, v in ipairs(t) do
    if check_equality(key, v) then return true end
  end
end

local function return_char(key)
  local w = window:new()
  w:open_window()
  w:add_key(key)
  return w.result and w.result.words[1].chinese or ''
end


local function set_mappings()
  local mappings = {
    ['0'] = 'close_window()',
    ['<BS>'] = 'backspace()',
    ['<CR>'] = 'close_window()',
    ['<Space>'] = 'close_window()',
  }
  for k,v in pairs(mappings) do
    api.nvim_buf_set_keymap(buf, 'n', k, ':lua require"imnvim".'..v..'<cr>', {
      nowait = true, noremap = true, silent = true
    })
  end
  local other_chars = {
    'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'
  }
  for k,v in ipairs(other_chars) do
    api.nvim_buf_set_keymap(buf, 'n', v, ':lua require"imnvim".add_key("'..v..'")<cr>', { nowait = true, noremap = true, silent = true })
    api.nvim_buf_set_keymap(buf, 'n', v:upper(), '', { nowait = true, noremap = true, silent = true })
    api.nvim_buf_set_keymap(buf, 'n',  '<c-'..v..'>', '', { nowait = true, noremap = true, silent = true })
  end
end

return {
  return_char = return_char,
}

