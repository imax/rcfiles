" Help file type tweaks
" FILE: "/home/max/.vim/ftplugin/help.vim" {{{
" LAST MODIFICATION: "Û“ƒ, 18 ·–“ 2001 14:14:11 +0300 (max)"
" (C) 2001 by Max Ischenko, <mfi@ukr.net>
" $Id: help.vim,v 1.1.1.1 2001/04/18 14:55:49 max Exp $ }}}

" Mappings to simplify help navigation
" Follow tags by pressing Enter
nmap <buffer> <CR> <C-]>
" Return from tag by pressing Backspace
nmap <buffer> <BS> <C-T>
nmap <buffer> o /'[a-z]\{2,\}'<CR>
nmap <buffer> O ?'[a-z]\{2,\}'<CR>
nmap <buffer> s /\|\S\+\|<CR>
nmap <buffer> S ?\|\S\+\|<CR>

