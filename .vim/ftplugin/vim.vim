" -*- vim -*-
" FILE: "/home/max/.vim/ftplugin/vim.vim" {{{
" LAST MODIFICATION: "Û¬‘, 21 ·–“ 2001 14:19:37 +0300 (max)"
" (C) 2001 by Max Ischenko, <ischenko@ukr.net>
" $Id: vim.vim,v 1.3 2001/04/21 11:32:32 max Exp $ }}}

:setlocal commentstring=\"\ %s
:setlocal sw=2
:setlocal ts=2

:nmap <buffer> <F9> :call <SID>VimExecuteLine()<CR>
:nmap <buffer> <F4> :so %<CR>

" Helper functions {{{1
"
" Execute line under cursor as Ex command {{{2
"
fun! s:VimExecuteLine()
	let line = getline(".")
	" Prepend with colon if doesn't have one
	if line !~ "^:"
		let line = ":" . line
	endif
	execute line
	"Clear status line
	echo
endf

