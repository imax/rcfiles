" drcstubs60.vim: Dr Chip's C Stubs  (a plugin)
"   isk is set to include # so as not to break #if
"
"  Author: Charles E. Campbell, Jr. (PhD)
"  Date:   December 19, 2000
"
"  Usage:
"
"   These maps all work during insert mode while editing a C
"   or C++ program.  Use either the shorthand or longhand maps
"   below, and the associated construct will be expanded to
"   include parentheses, curly braces, and the cursor will be
"   moved to a convenient location, still in insert mode, for
"   further editing.
"
"   Shorthand  Longhand
"   Map        Map
"   ---------  --------
"   i`         if`
"   e`         else`
"   ei`        elif`
"   f`         for`
"   w`         while`
"   s`         switch`
"   c`         case`
"   d`         default`
"              do`
"   E`         Edbg`    (see http://www.erols.com/astronaut/dbg)
"   R`         Rdbg`    (see http://www.erols.com/astronaut/dbg)
"   D`         Dprintf` (see http://www.erols.com/astronaut/dbg)
"
" Installation:
"
" This copy of DrC's C-Stubs is filetype plugin for vim 6.0: put it in
"  ${HOME}/.vim/ftplugin/c/    -and-   ${HOME/.vim/ftplugin/cpp/
" (or make suitable links) and put "filetype plugin on" in your <.vimrc>.
"
" "For I am convinced that neither death nor life, neither angles nor demons,
"  neither the present nor the future, nor any powers, nor height nor depth,
"  nor anything else in all creation, will be able to separate us from the
"  love of God that is in Christ Jesus our Lord."  Rom 8:38
" =======================================================================

" prevent re-load
if exists("g:loaded_drc")
  finish
endif
let g:loaded_drc= 1

" ---------------------------------------------------------------------
" Only done once
syn keyword cTodo COMBAK
syn match cTodo "^[- ]*COMBAK[- ]*$" 
set isk+=#

" ---------------------------------------------------------------------
" Functions:

" backquote calls DrChipCStubs function
inoremap <Plug>UseDrCStubs <Esc>:call <SID>DrChipCStubs()<CR>a

" ---------------------------------------------------------------------

" DrChipCStubs: this function changes the backquote into
"               text based on what the preceding word was
imap <unique> ` <Plug>UseDrCStubs
function! <SID>DrChipCStubs()
 let wrd=expand("<cWORD>")

 if     wrd == "if"
  exe "norm! bdWaif () \<CR>{\<CR>}\<Esc>$kkF("
 elseif wrd == "i"
  exe "norm! xaif() {\<CR>}\<Esc>$kF("

 elseif wrd == "else"
  exe "norm! bdWaelse {\<CR>}\<Esc>O \<c-h>\<Esc>"
 elseif wrd == "e"
  exe "norm! xaelse {\<CR>}\<Esc>O \<c-h>\<Esc>"

 elseif wrd == "elif"
  exe "norm! bdWaelse if() {\<CR>}\<Esc>$kF("
 elseif wrd == "ei"
  exe "norm! bdWaelse if() {\<CR>}\<Esc>$kF("

 elseif wrd == "for"
  exe "norm! bdWafor(;;) {\<CR>}\<Esc>$kF("
 elseif wrd == "f"
  exe "norm! xafor(;;) {\<CR>}\<Esc>$kF("

 elseif wrd == "while"
  exe "norm! bdWawhile() {\<CR>}\<Esc>$kF("
 elseif wrd == "w"
  exe "norm! xawhile() {\<CR>}\<Esc>$kF("

 elseif wrd == "switch"
  exe "norm! bdWaswitch() {\<CR>}\<Esc>$kF("
 elseif wrd == "s"
  exe "norm! xaswitch() {\<CR>}\<Esc>$kF("

 elseif wrd == "case"
  exe "norm! bdWacase :\<CR>break;\<Esc>khf:h"
 elseif wrd == "c"
  exe "norm! xacase :\<CR>break;\<Esc>khf:h"

 elseif wrd == "default"
  exe "norm! bdWadefault :\<CR>break;\<Esc>O \<c-h>\<Esc>"
 elseif wrd == "d"
  exe "norm! xadefault :\<CR>break;\<Esc>O \<c-h>\<Esc>"

 elseif wrd == "do"
  exe "norm! bdWado {\<CR>} while();\<Esc>O \<c-h>\<Esc>"

 elseif wrd == "Edbg"
  exe "norm! bdWaEdbg((\"\<Esc>ma[[?)\<CR>%BdwP`apa()\"));\<Esc>F("
 elseif wrd == "E"
  exe "norm! xaEdbg((\"\<Esc>ma[[?)\<CR>%BdwP`apa()\"));\<Esc>F("

 elseif wrd == "Rdbg"
  exe "norm! bdWaRdbg((\"\<Esc>ma[[?)\<CR>%BdwP`apa\"));\<Esc>F\"h"
 elseif wrd == "R"
  exe "norm! xaRdbg((\"\<Esc>ma[[?)\<CR>%BdwP`apa\"));\<Esc>F\"h"

 elseif wrd == "Dprintf"
  exe "norm! bdWaDprintf((1,\"\"));\<Esc>4h"
 elseif wrd == "D"
  exe "norm! xaDprintf((1,\"\"));\<Esc>4h"

 else
  exe "norm! a`\<Esc>"
 endif
endfunction

" ---------------------------------------------------------------------

