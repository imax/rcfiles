" tex.vim:
"  Author:  Charles E. Campbell, Jr.
"  Date:    August 25, 2000
"  Version: 1.00
"
" Usage:
"   Double-quotes automatically converted to ``...'' 
"   Construct expanded upon use of backquote
"   ie.  enum`   ->
"                    \begin{enumerate}
"                      \item <cursor here>
"                    \end{enumerate}
"
"   Both of these kinds of expansions are taken
"   during insert mode.
"
" Abbreviations:
"   Short Form  Long Form
"    enum`      enumerate`
"    eqn`       equation`
"    eqna`      eqnarray`
"    item`      itemize`
"    mini`      minipage`
"    tab`       tabular`    (needs TEXSTUB environment variable to
"                            hold path to directory holding <tabular.tex>)
"
" If none of the above abbreviations immediately precedes the backquote,
" then the backquote will be inserted as is.

inoremap `	<Esc>:call DrChipTexStubs()<CR>a
au BufNewFile,BufReadPost *.tex				ino " <c-r>=TexQuotes()<cr>

" ---------------------------------------------------------------------

function! DrChipTexStubs()
 let wrd=expand("<cWORD>")

 if     wrd == "enumerate"
  exe "norm! bi\\begin{\<Esc>ea}\<CR>\\end{enumerate}\<Esc>ko  \\item \<Esc>"
 elseif wrd == "enum"
  exe "norm! bi\\begin{\<Esc>eaerate}\<CR>\\end{enumerate}\<Esc>ko  \\item \<Esc>"

 elseif wrd == "itemize"
  exe "norm! bi\\begin{\<Esc>ea}\<CR>\\end{itemize}\<Esc>ko  \\item \<Esc>"
 elseif wrd == "item"
  exe "norm! bi\\begin{\<Esc>eaize}\<CR>\\end{itemize}\<Esc>ko  \\item \<Esc>"

 elseif wrd == "equation"
  exe "norm! bi\\begin{\<Esc>ea}\<CR>\\end{equation}\<Esc>ko\<Esc>"
 elseif wrd == "eqn"
  exe "norm! bi\\begin{\<Esc>exauation}\<CR>\\end{equation}\<Esc>ko\<Esc>"

 elseif wrd == "eqnarray"
  exe "norm! bi\\begin{\<Esc>ea}\<CR>\\end{itemize}\<Esc>ko  variable & = & value \\\\\<Esc>0fvh"
 elseif wrd == "eqna"
  exe "norm! bi\\begin{\<Esc>earray}\<CR>\\end{eqnarray}\<Esc>ko  variable & = & value \\\\\<Esc>0fvh"

 elseif wrd == "tabular" || wrd == "tab"
  exe "norm! bdw\<Esc>"
  r $TEXSTUB/tabular.tex
  exe "norm! /{tabular}/\<CR>"
 
 elseif wrd == "minipage" || wrd == "mini"
  exe "norm! bdwi\\begin{minipage}[H]{4in}\<CR>\\end{minipage}\<Esc>ko\<Esc>"

 else
  exe "norm! a`\<Esc>"
 endif
endfunction

" ---------------------------------------------------------------------

" TexQuotes: converts a '"' into `` or '' in LaTeX.
"            Supports an imap
fu! TexQuotes()
  let line   = getline(".")
  let curpos = col(".")-1
  let insert = "''"
  let left   = strpart(line, curpos-1, 1)

  if left == "\\"
    exe "norm! hr\"i\"\<Esc>l"
    let insert = ''
  elseif left == ' ' || left == '	' || left == ''
    let insert = '``'
    endif
  return insert
endfu

" ---------------------------------------------------------------------
