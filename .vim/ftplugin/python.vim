" 
" Customizations for the Python mode.
" 

setlocal ts=4 sw=4 et tw=90
compiler nose

iabbr <buffer> sae self.assertEquals
iabbr <buffer> sar self.assertRaises
iabbr <buffer> THAT <C-R>=expand("#:p:t:r")<CR>
iabbr <buffer> THIS <C-R>=expand("%:p:t:r")<CR>

imap <buffer> <C-s> self.

nmap <buffer> ,al Go# vim: set et ts=4 sw=4: <Esc><C-o>
nmap <buffer> ,as Go# source: <C-R>#<Esc>:s!\\!/!g<CR><C-o>
nmap <buffer> ,at Go# test: <C-R>#<Esc>:s!\\!/!g<CR><C-o>
nmap <buffer> ,c :setlocal tw=65<CR>
nmap <buffer> ,C :setlocal tw=90<CR>

"inoremap <Nul> <C-x><C-o>
setlocal makeprg=python\ -c\ \"import\ py_compile,sys;\ sys.stderr=sys.stdout;\ py_compile.compile(r'%')\"
setlocal efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
