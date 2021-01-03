local pbind = require('publibs.plbind')
local map_cr = pbind.map_cr
local map_cu = pbind.map_cu
local map_cmd = pbind.map_cmd
local map_args = pbind.map_args
local vim = vim

local mapping = setmetatable({}, { __index = { vim = {} } })

function mapping:load_vim_define()
  self.vim= {
    -- Vim map
    ["n|Y"]          = map_cmd('y$'),
    ["n|]b"]         = map_cu('bp'):with_noremap(),
    ["n|[b"]         = map_cu('bn'):with_noremap(),
    -- Insert
    -- command line
    ["c|<C-b>"]      = map_cmd('<Left>'):with_noremap(),
    ["c|<C-f>"]      = map_cmd('<Right>'):with_noremap(),
    ["c|<C-a>"]      = map_cmd('<Home>'):with_noremap(),
    ["c|<C-e>"]      = map_cmd('<End>'):with_noremap(),
    ["c|<C-d>"]      = map_cmd('<Del>'):with_noremap(),
    ["c|<C-h>"]      = map_cmd('<BS>'):with_noremap(),
    -- leader map
    ["n|<leader>cd"] = map_cu('cd %:p:h<CR>:pwd'):with_noremap(),
    ["n|<leader>vr"] = map_cu('source $MYVIMRC'):with_noremap():with_silent(),
  }
end

local function load_mapping()
  mapping:load_vim_define()
  pbind.nvim_load_mapping(mapping.vim)
end

load_mapping()
