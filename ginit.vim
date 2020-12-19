" ==================================================
" gui config 
" ==================================================
if exists('g:GuiLoaded')
    GuiPopupmenu 0
    GuiFont! Consolas:h12
    call GuiWindowMaximized(1)
endif

" if has('win32')
"     set guifont=Consolas:h12:cANSI
"     set guifontwide=YaHei_Mono:h12.5:cGB2312
" elseif has('mac')
"     set guifont=Consolas:h16
" elseif has('unix')
"     set guifont=Consolas\ 12
"     set guifontwide=YaHei_Mono_Hybird_Consolas\ 12.5
" endif
