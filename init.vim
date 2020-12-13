" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin(stdpath('data') . '/plugged')
" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'ojroques/vim-scrollstatus'
Plug 'junegunn/vim-easy-align'
Plug 'preservim/nerdcommenter'
Plug 'itchyny/lightline.vim'
Plug 'rakr/vim-one'
Plug 'liuchengxu/vista.vim'
Plug 'liuchengxu/vim-which-key' "不能按需加载，否则which_key#register找不到
Plug 'mhinz/vim-startify'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'machakann/vim-highlightedyank'
Plug 'vim-scripts/argtextobj.vim'
Plug 'ervandew/supertab'

" Any valid git URL is allowed
" Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" Multiple Plug commands can be written in a single line using | separators
" Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" Using a non-default branch
" Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
" Plug 'neoclide/coc.nvim', { 'branch': 'release' }
" Plug 'antoinemadec/coc-fzf', {'branch': 'release'}

" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
" Plug 'fatih/vim-go', { 'tag': '*' }

" Plugin options
" Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }


" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Unmanaged plugin (manually installed and updated)
" Plug '~/my-prototype-plugin'

" Initialize plugin system
call plug#end()

" 使得复制粘贴不会自动注释
set paste
set hidden
set nobackup
set nowritebackup
set updatetime=300
set timeoutlen=500
set shortmess+=c
set nu
filetype plugin on
" 设置为双字宽显示，否则无法完整显示如:☆
set ambiwidth=double
set t_ut= " 防止vim背景颜色错误
set showmatch " 高亮匹配括号
set matchtime=1
set report=0
set ignorecase
set noeb
set softtabstop=4
set shiftwidth=4
set tabstop=4
set expandtab
set infercase
set autoindent
set smartindent
set cindent
set nobackup
set autoread
set nocompatible
set foldmethod=syntax
colorscheme one
set termguicolors
set wildmenu
set wildmode=full
set hlsearch
set incsearch
set ignorecase
set smartcase
if has('gui_running')
    set mouse=a
endif

" 必须先下载im-select.exe
if has('win32')
    augroup imeauto
	autocmd InsertLeave * :silent :!C:\\im-select\\im-select.exe 1033
	autocmd InsertEnter * :silent :!C:\\im-select\\im-select.exe 2052
    augroup END
elseif has('unix')
	inoremap <ESC> <ESC> :set iminsert=0<CR>
endif

if has('unix')
    map <silent><F5> :call RunCode()<CR>
endif

" < 表示去掉文件的后缀
func! RunCode()
    exec "w"
    if &filetype == 'c'
	exec '!gcc -Werror % -o %<'
	exec '!time ./%<'
    elseif &filetype == 'c++'
	exec '!g++ -Werror % -o %<'
	exec '!time ./%<'
    elseif &filetype == 'java'
	exec '!javac %'
	exec '!time java %:.:r'
    elseif &filetype == 'python'
	exec '!time python3 %'
    elseif &filetype == 'go'
	exec '!time go run %'
    elseif &filetype == 'vim'
	exec 'source ~/.config/nvim/init.vim'
	exec 'PlugInstall'
    elseif &filetype == 'rust'
	exec '!cargo run'
    endif
endfunc


nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

let g:mapleader = "\<Space>"

nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :<c-u>WhichKeyVisual '<Space>'<CR>
" Define prefix dictionary
let g:which_key_map =  {}
" Second level dictionaries:
" 'name' is a special field. It will define the name of the group, e.g., leader-f is the "+file" group.
" Unnamed groups will show a default empty string.

" =======================================================
" Create menus based on existing mappings
" =======================================================
" You can pass a descriptive text to an existing mapping.


let g:which_key_map.f = {
			\ 'name': '+file',
			\ 'f':    ['Files',           'fzf-files'],
			\ 's':    ['update',          'save-files'],
			\ 't':    ['NERDTreeToggle',  'tree-files'],
			\ }
nnoremap <silent> <leader>fc :edit $MYVIMRC<CR>
let g:which_key_map.f.c = 'open-vimrc'
nnoremap <silent> <leader>fr :source $MYVIMRC<CR>
let g:which_key_map.f.r = 'reload-vimrc'

let g:which_key_map.o = {
			\ 'name': '+open',
			\ 'q':    [ 'copen',  'open-quickfix' ]    ,
			\ 'l':    [  'lopen', 'open-locationlist' ],
			\ }


let g:which_key_map.w = {
	    \ 'name' : '+windows',
	    \ 'w' : ['<C-W>w',     'other-window']          ,
	    \ 'd' : ['<C-W>c',     'delete-window']         ,
	    \ '-' : ['<C-W>s',     'split-window-below']    ,
	    \ '|' : ['<C-W>v',     'split-window-right']    ,
	    \ '2' : ['<C-W>v',     'layout-double-columns'] ,
	    \ 'h' : ['<C-W>h',     'window-left']           ,
	    \ 'j' : ['<C-W>j',     'window-below']          ,
	    \ 'l' : ['<C-W>l',     'window-right']          ,
	    \ 'k' : ['<C-W>k',     'window-up']             ,
	    \ 'H' : ['<C-W>5<',    'expand-window-left']    ,
	    \ 'J' : [':resize +5', 'expand-window-below']   ,
	    \ 'L' : ['<C-W>5>',    'expand-window-right']   ,
	    \ 'K' : [':resize -5', 'expand-window-up']      ,
	    \ '=' : ['<C-W>=',     'balance-window']        ,
	    \ 's' : ['<C-W>s',     'split-window-below']    ,
	    \ 'v' : ['<C-W>v',     'split-window-right']    ,
	    \ '?' : ['Windows',    'fzf-window']            ,
	    \ }

let g:which_key_map.b = {
	    \ 'name' : '+buffer',
	    \ '1' : ['b1',               'buffer 1']        ,
	    \ '2' : ['b2',               'buffer 2']        ,
	    \ 'd' : ['bd',               'delete-buffer']   ,
	    \ 'f' : ['bfirst',           'first-buffer']    ,
	    \ 'h' : ['Startify',         'home-buffer']     ,
	    \ 'l' : ['blast',            'last-buffer']     ,
	    \ 'n' : ['bnext',            'next-buffer']     ,
	    \ 'p' : ['bprevious',        'previous-buffer'] ,
	    \ '?' : ['Buffers',          'fzf-buffer']      ,
	    \ }
call which_key#register('<Space>', "g:which_key_map")

let g:lightline = {
      \ 'colorscheme': 'one',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }

set laststatus=2
"===============================================

" Create default mappings
let g:NERDCreateDefaultMappings = 1
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1
" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" Enable NERDCommenterToggle to check all selected lines is commented or not 
let g:NERDToggleCheckAllLines = 1

" FZF
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)

" End
