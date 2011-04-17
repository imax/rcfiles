" "GUI startup file."


" GUI-related options {{{1
set guifont=DejaVu\ Sans\ Mono\ 11
set lines=60 columns=95
winpos 2476 0
set guicursor=a:blinkon0,n:block-Cursor-blinkon0
set guioptions=agilm
"set guioptions-=tmr
set mousehide
set mouse=a
set nohlsearch
" }}}

" Menus {{{1
25amenu &Misc.Start\ WManager	:WManager<CR>
25amenu &Misc.End\ WManager	:WMClose<CR>
25amenu &Misc.&Commit\ file	:call CVSCommitFile()<CR>
25amenu &Misc.CVS\ &status	:call CVSPrintStatus()<CR>
25amenu &Misc.CVS\ &diff	:!cvs dif %<CR>
25amenu &Misc.-Sep-	:
25amenu &Misc.&Mail\ buffer\ to	:call MailFileTo()<CR>
25amenu &Misc.Load\ typos\ list :so ~/.vim/xp-wordlist.vim<CR>
25amenu &Misc.Set\ executable\ bit :call SetExecutableBit()<CR>
menu Encoding.windows-1251 :e ++enc=cp1251<CR>
menu Encoding.ibm-866      :e ++enc=ibm866<CR>
menu Encoding.koi8-r       :e ++enc=koi8-r<CR>
menu Encoding.utf-8        :e ++enc=utf-8<CR>
menu Encoding.unicode      :e ++enc=ucs-2<CR>
" }}}


" Disable visual bell capability
set t_vb=

" Colorscheme {{{1
:colo wombat
":colo darkslategray
highlight Cursor guifg=Black guibg=Green gui=bold
highlight Folded guibg=DarkSlateGrey guifg=Thistle
