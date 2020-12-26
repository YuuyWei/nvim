local global = require 'global'
local fs = require 'publibs.plfs'
local vim = vim
local dein = {
	toml = global.modules_dir..'dein.toml',
	lazy_toml = global.modules_dir..'dein_lazy.toml',
	ft_toml = global.modules_dir..'dein_ft.toml',
}

function dein:load_repos()
	local dein_path = global.cache_dir .. 'dein'
	local dein_dir = global.cache_dir ..'dein/repos/github.com/Shougo/dein.vim'
	local cmd = "git clone https://github.com/Shougo/dein.vim " .. dein_dir

	if vim.fn.has('vim_starting') then
		vim.api.nvim_set_var('dein#auto_recache',1)
		vim.api.nvim_set_var('dein#install_max_processes',12)
		vim.api.nvim_set_var('dein#install_progress_type',"title")
		vim.api.nvim_set_var('dein#enable_notification',1)
		vim.api.nvim_set_var('dein#lazy_rplugins',1)
		vim.api.nvim_set_var('dein#install_log_filename',global.cache_dir ..'dein.log')

		if not vim.o.runtimepath:match('/dein.vim') then
			if not fs.isdir(dein_dir) then
				os.execute(cmd)
			end
			vim.o.runtimepath = vim.o.runtimepath ..','..dein_dir
		end
	end

	if vim.fn['dein#load_state'](dein_path) == 1 then
		vim.fn['dein#begin'](dein_path, {vim.fn.expand('<sfile>'), self.toml, self.lazy_toml, self.ft_toml})
		vim.fn['dein#load_toml'](self.toml, {lazy=0})
		vim.fn['dein#load_toml'](self.lazy_toml, {lazy=1})
		vim.fn['dein#load_toml'](self.ft_toml)
		vim.fn['dein#end']()
		vim.fn['dein#save_state']()

		if vim.fn['dein#check_install']() == 1 then
			vim.fn['dein#install']()
		end
	end

	vim.api.nvim_command('filetype plugin indent on')

	if vim.fn.has('vim_starting') == 1 then
		vim.api.nvim_command('syntax enable')
	end
end

return dein
