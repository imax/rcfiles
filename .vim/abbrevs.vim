" Static abbreviations

:scriptencoding utf-8

" Insert-mode abbreviations {{{
iab rt return
iab DATE <C-R>=strftime("%Y-%b-%d")<CR>
iab TIME <C-R>=strftime("%H:%M")<CR>
iab DATETIME <C-R>=strftime("%Y-%b-%d %H:%M")<CR>
" Add a lot of standard typos from Office XP
":so ~/.vim/xp-wordlist.vim
" Custom ones.
iab ecoh echo
iab est set
iab kye key
iab resutl result
" }}}

" Command-mode abbreviations {{{
:cab E e
:cab B b
" }}}
