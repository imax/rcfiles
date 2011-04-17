"
" file-type plugin for the Mail.
"

setlocal ignorecase
setlocal infercase
setlocal nohlsearch

:iab <buffer> tia Thanks in advance
:iab <buffer> j2c Just my $0.02 worth.
:iab <buffer> pov point of view

:nmap <buffer> <F9> mzG:?^-- $<CR>o<ESC>dG:r !afortune<CR>`z
:nmap <buffer> <F8> mzG:?^-- $<CR>o<ESC>dG:r ~/.sig-official<CR>:1s/From:.*/From: Maksim Ischenko <mfi@ukr.net>/<CR>`z
:nmap <buffer> <F10> :wq<CR>
:nmap <buffer> Q !}/home/max/bin/par 72<CR>}
nmap <buffer> q :wq<CR>
"nmap <buffer> Q :q!<CR>
" Chage subject line
nmap <buffer> <LocalLeader>cs 1G/^Subject: <CR>yypIX-Old-<ESC>-W

" Cut quoted text
"inoremap <buffer> [.. [...]
vnoremap <buffer> x s<CR>[...]<CR><Esc>j

" Reformat a paragraph
:imap <buffer> <C-j> <Esc>gqap:'[,']s/  \+/ /ge<Cr><Insert>
:nmap <buffer> <C-j> gqap:'[,']s/  \+/ /ge<Cr>

" Delete quote line with no text
silent! %s/^>\s*$//e
" Join multiple empty lines into one
silent! :g/^$/,/./-j

" Delete various junk text blocks
" Delete KAV notice
silent! :/^> =\{40,}$/,/Checked by KAV/d
"Delete signature of the original author
silent! :/^> -- \?$/,/^-- $/-2d
" Delete mailman list banner
silent! :/^> [_-]\{40,}$/,/^> http.*listinfo/d
" Delete Yahoo! banner
silent! :/^> [_-]\{24} Yahoo. Groups/,/^> Your use of Yahoo! Groups/+1d

normal gg}
