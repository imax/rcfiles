" C++ ft tweaks
" FILE: "/home/max/.vim/ftplugin/cpp_default.vim" {{{1
" LAST MODIFICATION: "Чтв, 19 Апр 2001 13:09:08 +0300 (max)"
" (C) 2001 by Max Ischenko, <mfi@ukr.net>
" $Id: cpp_default.vim,v 1.2 2001/04/20 14:30:11 max Exp $
" }}}

setlocal cindent
setlocal fo=croql
setlocal ts=4
setlocal sw=4
setlocal tm=3000

imap <buffer> { {<CR> <BS><CR>}<Up><End>
imap <buffer> ~~ virtual ~() <C-v>{}<C-o>4h
ino <buffer>  rt0 return 0;
"inoremap <buffer> #i #include ""<Left>
"inoremap <buffer> #I #include <><Left>
map <buffer> 	<F9>	:update<CR>:mak<CR> 
nmap <buffer> ds dt;
nmap <buffer> <F4> :A<CR>
imap <buffer> <F4> <C-o>:A<CR>
"cmap <buffer> <C-T> e <C-R>=expand("%:r")<CR>.

nmap <buffer> <F7> O<C-u><CR><Esc>j==f(B?\k\+::<CR>yt:<C-O>i<C-R>"::<Esc>$xo{

:iab <buffer> rt return
:iab <buffer> #d #define
:iab <buffer> #i #include
:iab <buffer> ct const
:iab <buffer> vv virtual void
:iab <buffer> cc const char *
:iab <buffer> cs const string &
:iab <buffer> ci const int
:iab <buffer> e1 exit(1);

:command! -nargs=0 CHeader call s:PrintCHeaderDefine()
:command! -nargs=0 Legal call s:PrintLegalBox()
:command! -nargs=0 Class call s:InsertCxxClassTemplate()

au! BufNewFile *.h :CHeader | :Legal
au! BufNewFile *Test.cpp :call s:InsertTestUnit()
au! BufNewFile *.cpp :Legal

fun! s:InsertTestUnit()
	let name = expand("%:h")
	echo name
endfun

fun! s:InsertCxxClassTemplate()
	append
class FOO
{
	public:
};

.
	normal 4kwcw
endfun

" Print block of ifdef's (this is usual practice for c header files).
" Move cursor to the second of three empty lines in the middle.
fun! s:PrintCHeaderDefine()
 let fname = expand("%:t:r")
 let fname = substitute(fname, "[\.-]", "_", "ge")
 :append
#ifndef FOO
#define FOO



#endif /* FOO */
.
 silent :exe ':%s/FOO/_\U' . fname . '_H_/ge'
 normal 2k
endfun

fun! s:PrintLegalBox()
	normal mpgg
	:insert
/*
 * This file is part of FOO project.
 *
 * Copyright (c) 2002 CJSC Malva. All rights reserved.
 * Original author: Max Ischenko <max@malva.ua>.
 */

.
  if exists("g:project")
		:exec "normal :2s/FOO/" . g:project . "/\<CR>"
	endif
	normal `p
endfun

finish
