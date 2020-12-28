if exists('g:loaded_imnvim') | finish | endif

let s:save_cpo = &cpo
set cpo&vim

hi def link WhidHeader      Number
hi def link WhidSubHeader   Identifier

command! Imnvim lua require('imnvim')

let &cpo = s:save_cpo
unlet s:save_cpo

let g:loaded_imnvim = 1
