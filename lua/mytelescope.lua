local M = {}
local fn = vim.fn

function M.vim_config()
  require('telescope.builtin').git_files {
    cwd = fn.stdpath('config'),
    prompt = '~ vimrc ~',
    height = 10,

    layout_strategy = 'horizontal',
    layout_options = {
      preview_width = 0.75,
    }
  }
end

return M
