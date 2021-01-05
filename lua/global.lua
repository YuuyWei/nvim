local global = {}
local home  =  vim.fn.getenv("HOME")
local path_sep = global.is_windows and '\\' or '/'
local os_name = vim.loop.os_uname().sysname

function global:load_variables()
  self.is_mac      = os_name == 'Darwin'
  self.is_linux    = os_name == 'Linux'
  self.is_windows  = os_name == 'Windows'
  self.vim_path    = vim.fn.stdpath('config')
  self.cache_dir   = vim.fn.stdpath('data')
  self.modules_dir = self.vim_path .. path_sep..'modules'..path_sep
  self.path_sep    = path_sep
  self.home        = home
end

global:load_variables()

return global

