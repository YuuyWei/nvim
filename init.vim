" if existing no vim-plug, then install
if empty(glob(stdpath('data') . '/plugged'))
    if has('unix')
        !sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    endif
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin(stdpath('data') . '/plugged')
" Make sure you use single quotes
" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
"
" color scheme
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'machakann/vim-highlightedyank'
Plug 'itchyny/lightline.vim'
Plug 'mhinz/vim-startify'
Plug 'rakr/vim-one'

" vim easy editting
Plug 'junegunn/vim-easy-align'
Plug 'liuchengxu/vista.vim'
Plug 'preservim/nerdcommenter'
Plug 'liuchengxu/vim-which-key' "不能按需加载，否则which_key#register找不到
Plug 'tpope/vim-fugitive'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/argtextobj.vim'
Plug 'brglng/vim-im-select'
Plug 'mbbill/undotree'

" markdown and wiki
" Plug 'dhruvasagar/vim-table-mode', {'on': 'TableModeToggle'}
Plug 'vimwiki/vimwiki'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install()  }, 'for': ['markdown', 'vim-plug'] }

" Any valid git URL is allowed
" Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" Multiple Plug commands can be written in a single line using | separators
" Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" On-demand loading
" Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" Using a non-default branch
" Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'antoinemadec/coc-fzf', {'branch': 'release'}
Plug 'honza/vim-snippets'

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
            \ 'name': '+file/git',
            \ 'f':    ['Files',   'fzf-files'],
            \ 's':    ['update',  'save-files'],
            \ 'l':    ['Gpull',   'git-pull'],
            \ 'w':    ['Gwrite',  'git-write'],
            \ 'c':    ['Gcommit', 'git-commit'],
            \ }
let g:which_key_map.f.p = 'git-save&push'
nnoremap <silent> <leader>fp :call VimConfigGitPush()<CR>
func! VimConfigGitPush()
    exec "Gwrite"
    exec "Gcommit -m 'information update'"
    exec "Gpush -u origin main"
endfunc


let g:which_key_map.v = {
            \ 'name': '+vimrc',
            \ 'c':    'open-vimrc',
            \ 'r':    'reload-vimrc',
            \}
nnoremap <silent> <leader>vc :edit $MYVIMRC<CR>
nnoremap <silent> <leader>vr :source $MYVIMRC<CR>

let g:which_key_map.i = {
            \ 'name' : '+windows',
            \ 'o': [  'lopen',     'open-locationlist' ],
            \ 'q': [ 'copen',      'open-quickfix' ]    ,
            \ 'w': ['<C-W>w',      'other-window']          ,
            \ 'd': ['<C-W>c',      'delete-window']         ,
            \ '-': ['<C-W>s',      'split-window-below']    ,
            \ '|': ['<C-W>v',      'split-window-right']    ,
            \ '2': ['<C-W>v',      'layout-double-columns'] ,
            \ 'h': ['<C-W>h',      'window-left']           ,
            \ 'j': ['<C-W>j',      'window-below']          ,
            \ 'l': ['<C-W>l',      'window-right']          ,
            \ 'k': ['<C-W>k',      'window-up']             ,
            \ 'H': ['<C-W>5<',     'expand-window-left']    ,
            \ 'J': [':resize +5',  'expand-window-below']   ,
            \ 'L': ['<C-W>5>',     'expand-window-right']   ,
            \ 'K': [':resize -5',  'expand-window-up']      ,
            \ '=': ['<C-W>=',      'balance-window']        ,
            \ 's': ['<C-W>s',      'split-window-below']    ,
            \ 'v': ['<C-W>v',      'split-window-right']    ,
            \ '?': ['Windows',     'fzf-window']            ,
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

" basic setting
" 使得复制粘贴不会自动注释，会莫名奇妙导致autoindent无效
set pastetoggle=<f12>
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
set foldmethod=marker
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
" if has('win32')
"     set shell=powershell shellquote=( shellpipe=\| shellxquote=
"     set shellcmdflag=-NoLogo\ -NoProfile\ -ExecutionPolicy\ RemoteSigned\ -Command
"     set shellredir=\|\ Out-File\ -Encoding\ UTF8
" endif

" 必须先下载im-select.exe
let g:im_select_command = "C:\\im-select\\im-select.exe"
let g:im_select_default = "1033"


" autorun
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

"===============================================
" nerdcommenter

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

" coc
"
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.

inoremap <silent><expr> <TAB>
			\ pumvisible() ? "\<C-n>" :
			\ <SID>check_back_space() ? "\<TAB>" :
			\ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
        call CocActionAsync('doHover')
    else
        execute '!' . &keywordprg . " " . expand('<cword>')
    endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')


augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder.
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>la  <Plug>(coc-codeaction-selected)
nmap <leader>la  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
" nmap <leader>pa  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>lq  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
    nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
    inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
    inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
    vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <leader>lld  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <leader>lle  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <leader>llc  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <leader>llo  :<C-u>CocList outline<cr>
" Search workleader symbols.
nnoremap <silent><nowait> <leader>lls  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <leader>llj  :<C-u>CocNext<CR>
" Do default action for previous ilem.
nnoremap <silent><nowait> <leader>llk  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <leader>llr  :<C-u>CocListResume<CR>

" coc snippets 
" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

" Use <leader>x for convert visual selected code to snippet
xmap <leader>x  <Plug>(coc-convert-snippet)

let g:which_key_map.l = {
            \ 'name': '+coc-lsp',
            \ 'r':    'coc-rename'    ,
            \ 'f':    'coc-format-selected',
            \ 'a':    'coc-codeaction',
            \ 'q':    'coc-quickfix',
            \ }

let g:which_key_map.l.l = {
            \ 'name': '+coc-list',
            \ 'd':    'coc-list-diagnostics',
            \ 'e':    'coc-list-extensions',
            \ 'c':    'coc-list-commands',
            \ 'o':    'coc-list-outline',
            \ 's':    'coc-list-symbols',
            \ 'j':    'coc-list-next',
            \ 'k':    'coc-list-previous',
            \ 'r':    'coc-list-resume',
            \ }

" vim-wiki
let g:which_key_map.w = {
            \ 'name': '+wiki',
            \ 'i':    'wiki-diary-index',
            \ 't':    'wiki-table-index',
            \ 'w':    'wiki-index',
            \ 's':    'wiki-select',
            \ 'd':    'wiki-delete-file',
            \ 'h':    'wiki-2HTML',
            \ 'hh':    'wiki-2HTML&browse',
            \ 'n':    'wiki-goto',
            \ 'r':    'wiki-rename-file',
            \ }

let g:which_key_map.w[' '] = {
            \ 'name': '+wiki-diary',
            \ 'i':    'wiki-diary-generate-links',
            \ 't':    'wiki-diary-tablemake-notes',
            \ 'w':    'wiki-diary-make-notes',
            \ 'm':    'wiki-diary-make-tomorrow-notes',
            \ 'y':    'wiki-diary-make-yesterday-notes',
            \ }

" let g:vimwiki_list = [{'path': '~/vimwiki/',
"                       \ 'syntax': 'markdown', 'ext': '.md'}]

" markdown preview 
" set to 1, nvim will open the preview window after entering the markdown buffer
" default: 0
let g:mkdp_auto_start = 0

" set to 1, the nvim will auto close current preview window when change
" from markdown buffer to another buffer
" default: 1
let g:mkdp_auto_close = 1

" set to 1, the vim will refresh markdown when save the buffer or
" leave from insert mode, default 0 is auto refresh markdown as you edit or
" move the cursor
" default: 0
let g:mkdp_refresh_slow = 0

" set to 1, the MarkdownPreview command can be use for all files,
" by default it can be use in markdown file
" default: 0
let g:mkdp_command_for_global = 0

" set to 1, preview server available to others in your network
" by default, the server listens on localhost (127.0.0.1)
" default: 0
let g:mkdp_open_to_the_world = 0

" use custom IP to open preview page
" useful when you work in remote vim and preview on local browser
" more detail see: https://github.com/iamcco/markdown-preview.nvim/pull/9
" default empty
let g:mkdp_open_ip = ''

" specify browser to open preview page
" default: ''
let g:mkdp_browser = ''

" set to 1, echo preview page url in command line when open preview page
" default is 0
let g:mkdp_echo_preview_url = 0

" a custom vim function name to open preview page
" this function will receive url as param
" default is empty
let g:mkdp_browserfunc = ''

" options for markdown render
" mkit: markdown-it options for render
" katex: katex options for math
" uml: markdown-it-plantuml options
" maid: mermaid options
" disable_sync_scroll: if disable sync scroll, default 0
" sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
"   middle: mean the cursor position alway show at the middle of the preview page
"   top: mean the vim top viewport alway show at the top of the preview page
"   relative: mean the cursor position alway show at the relative positon of the preview page
" hide_yaml_meta: if hide yaml metadata, default is 1
" sequence_diagrams: js-sequence-diagrams options
" content_editable: if enable content editable for preview page, default: v:false
" disable_filename: if disable filename header for preview page, default: 0
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {},
    \ 'content_editable': v:false,
    \ 'disable_filename': 0
    \ }

" use a custom markdown style must be absolute path
" like '/Users/username/markdown.css' or expand('~/markdown.css')
let g:mkdp_markdown_css = ''

" use a custom highlight style must absolute path
" like '/Users/username/highlight.css' or expand('~/highlight.css')
let g:mkdp_highlight_css = ''

" use a custom port to start server or random for empty
let g:mkdp_port = ''

" preview page title
" ${name} will be replace with the file name
let g:mkdp_page_title = '「${name}」'

" recognized filetypes
" these filetypes will have MarkdownPreview... commands
let g:mkdp_filetypes = ['markdown']

" keymaps
nmap <leader>mp <Plug>MarkdownPreview
nmap <leader>ms <Plug>MarkdownPreviewStop
nmap <leader>mt <Plug>MarkdownPreviewToggle
let g:which_key_map.m = {
            \ 'name' : '+markdown-preview',
            \ 'p' : 'markdown-preview',
            \ 's' : 'markdown-preview-stop',
            \ 't' : 'markdown-preview-toggle',
            \}

" easy align
" function! s:easy_align_1st_eq(type, ...)
"     '[,']EasyAlign=
" endfunction
" nnoremap <Leader>= :set opfunc=<SID>easy_align_1st_eq<Enter>g@
" let g:which_key_map['='] = 'easy-align-1st-eq'
"
" function! s:easy_align_1st_colon(type, ...)
"     '[,']EasyAlign:
" endfunction
" nnoremap <Leader>: :set opfunc=<SID>easy_align_1st_colon<Enter>g@']]'
" let g:which_key_map[':'] = 'easy-align-1st-colon'

let g:easy_align_delimiters = {
\ '>': { 'pattern': '>>\|=>\|>' },
\ '/': { 'pattern': '//\+\|/\*\|\*/', 'ignore_groups': ['String'] },
\ '#': { 'pattern': '#\+', 'ignore_groups': ['String'], 'delimiter_align': 'l' },
\ ']': {
\     'pattern':       '[[\]]',
\     'left_margin':   0,
\     'right_margin':  0,
\     'stick_to_left': 0
\   },
\ ')': {
\     'pattern':       '[()]',
\     'left_margin':   0,
\     'right_margin':  0,
\     'stick_to_left': 0
\   },
\ 'd': {
\     'pattern': ' \(\S\+\s*[;=]\)\@=',
\     'left_margin': 0,
\     'right_margin': 0
\   }
\ }


