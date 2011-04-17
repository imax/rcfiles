" Vim indent file
" Language:	Tcl script
" Maintainer:	Max Ischenko
" Last Change:	2000 Nov 02

setlocal indentexpr=GetTclIndent()
setlocal cinkeys+==else,=esac,=fi,=done

" Only define the function once.
if exists("*GetTclIndent")
  finish
endif

function GetTclIndent()
  " Find a non-empty line above the current line.
  let lnum = v:lnum - 1
  while lnum > 0
    if getline(lnum) !~ '^\s*$'
      break
    endif
    let lnum = lnum - 1
  endwhile

  " Hit the start of the file, use zero indent.
  if lnum == 0
    return 0
  endif

  " Add a 'shiftwidth' after if, while, else, case, until, for, function()
  let ind = indent(lnum)
  let line = getline(lnum)
  "if line =~ '^\s*\(if\|else\|case\|while\|until\|for\)\>'
  if line =~ '{$'
    let ind = ind + &sw
  endif

  " Subtract a 'shiftwidth' on a else, esac, fi, done
  let line = getline(v:lnum)
  "if line =~ '^\s*\(else\|esac\|fi\|done\)\>' || line =~ '^\s*}'
  if line =~ '^\s*}'
    let ind = ind - &sw
  endif

  return ind
endfunction
