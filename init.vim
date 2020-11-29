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
" Plug 'crusoexia/vim-monokai'
" Plug 'kdheepak/lazygit.nvim'
Plug 'rakr/vim-one'
Plug 'liuchengxu/vista.vim'
Plug 'liuchengxu/vim-which-key' "不能按需加载，否则which_key#register找不到
Plug 'mhinz/vim-startify'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'


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

" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
" Plug 'fatih/vim-go', { 'tag': '*' }

" Plugin options
" Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

" Plugin outside ~/.vim/plugged with post-update hook
if has('unix')
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
endif
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
set nobackup
set autoread
set nocompatible
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
augroup imeauto
  autocmd InsertLeave * set imdisable
  autocmd InsertEnter * set noimdisable
augroup END
" inoremap <ESC> <ESC> :set iminsert=2<CR>

if has('unix')
map <silent><F5> :call RunCode()<CR>
endif

" < 表示去掉文件的后缀
func! RunCode()
    exec "w"
    if &filetype == 'c'
        exec '%g++ % -o %<'
        exec '!time ./%<'
    elseif &filetype == 'c++'
        exec '%g++ % -o %<'
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

let g:which_key_map.f = { 'name' : '+file' }

nnoremap <silent> <leader>fs :update<CR>
let g:which_key_map.f.s = 'save-file'

nnoremap <silent> <leader>fd :vs $MYVIMRC<CR>
let g:which_key_map.f.d = 'open-vimrc'
nnoremap <silent> <leader>fv :source $MYVIMRC<CR>
let g:which_key_map.f.v = 'reload-vimrc'

nnoremap <silent> <leader>oq  :copen<CR>
nnoremap <silent> <leader>ol  :lopen<CR>
let g:which_key_map.o = {
      \ 'name' : '+open',
      \ 'q' : 'open-quickfix'    ,
      \ 'l' : 'open-locationlist',
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

let g:lightline ={
            \ 'active': {
            \ 'right': [
            \['lineinfo'],
            \['scroll'],
            \ ['coc', 'fileformat', 'filetype']]
            \ },
            \ 'component_function':{
            \'scroll': 'ScrollStatus',
            \'coc': 'vista_nearest_method_or_function',
            \ },
            \ }
let g:scrollstatus_size = 10
let g:scrollstatus_symbol_track = ' '
let g:scrollstatus_symbol_bar = '█'
set laststatus=2

let g:vista_default_executive = 'coc'

let g:vista#renderer#icons = {
            \   "function": "\uf794",
            \   "variable": "\u0ec2",
            \  }


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

" " Use <c-space> to trigger completion.
" if has('nvim')
"   inoremap <silent><expr> <c-space> coc#refresh()
" else
"   inoremap <silent><expr> <c-@> coc#refresh()
" endif

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
autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
let g:which_key_map.l = {
      \ 'name' : '+lsp' ,
      \ }


" Symbol renaming.
nmap <leader>lr <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>lfm  <Plug>(coc-format-selected)
nmap <leader>lfm <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>laap` for current paragraph
xmap <leader>la  <Plug>(coc-codeaction-selected)
nmap <leader>la  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
" nmap <leader>la  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>lf  <Plug>(coc-fix-current)

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

" " Remap <C-f> and <C-b> for scroll float windows/popups.
" if has('nvim-0.4.0') || has('patch-8.2.0750')
"   nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
"   nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
"   inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
"   inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
"   vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
"   vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
" endif
"
" NeoVim-only mapping for visual mode scroll
" Useful on signatureHelp after jump placeholder of snippet expansion
" if has('nvim')
"   vnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#nvim_scroll(1, 1) : "\<C-f>"
"   vnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#nvim_scroll(0, 1) : "\<C-b>"
" endif

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
nnoremap <silent><nowait> <leader>ld  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <leader>le  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <leader>lc  :<C-u>CocList commands<cr>
" Find symbol of current document>l
nnoremap <silent><nowait> <leader>lo  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <leader>ls  :<C-u>CocList -I symbols<cr>
" Do default action for next item>l
nnoremap <silent><nowait> <leader>lj  :<C-u>CocNext<CR>
" Do default action for previous >ltem.
nnoremap <silent><nowait> <leader>lk  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <leader>lp  :<C-u>CocListResume<CR>

let g:coc_snippet_next = '<tab>'

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

" End
