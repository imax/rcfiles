" Tcl augments {{{
" (C) 2001 by Max Ischenko, <mfi@ukr.net>
" $Id: tcl.vim,v 1.1 2001/07/23 07:42:35 max Exp $ }}}

setlocal isk+=-,!,?
setlocal fo+=rol

cmap <buffer> <C-T> e <C-R>%<BS><BS>est
nmap <buffer> <LocalLeader>h :call <SID>InsertTclHeader()<CR>

fun! <SID>InsertTclHeader()
	exec "normal mzk0/^proc \<CR>ellyt 'zO\<CR>\<C-u># \<C-r>\" --\<CR>\<CR>"
	exec "normal A Arguments:\<CR>\<Tab>None.\<CR>\<CR>"
	exec "normal A Results:\<CR>\<Tab>None.\<CR>\<C-u>#"
	exec "normal ? --$\<CR>j"
endfun
