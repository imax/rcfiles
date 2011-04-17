" lisp.vim: highlights different levels of () with different shades of
"              grey.  Only good for gvim plus lisp
"  Author: Charles E. Campbell, Jr.
"  Date:   Mar 04, 2002
if has("gui_running")
  if version < 508
    command! -nargs=+ HiLink hi <args>
  else
    command! -nargs=+ HiLink hi def <args>
  endif

  syn region lispParen1           transparent matchgroup=lispP1 start="(" matchgroup=lispP1 end=")" contains=@lispListCluster,lispParen2
  syn region lispParen2 contained transparent matchgroup=lispP2 start="(" matchgroup=lispP2 end=")" contains=@lispListCluster,lispParen3
  syn region lispParen3 contained transparent matchgroup=lispP3 start="(" matchgroup=lispP3 end=")" contains=@lispListCluster,lispParen4
  syn region lispParen4 contained transparent matchgroup=lispP4 start="(" matchgroup=lispP4 end=")" contains=@lispListCluster,lispParen5
  syn region lispParen5 contained transparent matchgroup=lispP5 start="(" matchgroup=lispP5 end=")" contains=@lispListCluster,lispParen6
  syn region lispParen6 contained transparent matchgroup=lispP6 start="(" matchgroup=lispP6 end=")" contains=@lispListCluster,lispParen7
  syn region lispParen7 contained transparent matchgroup=lispP7 start="(" matchgroup=lispP7 end=")" contains=@lispListCluster,lispParen1
  
  HiLink lispP1 term=NONE cterm=NONE gui=NONE guifg=white
  HiLink lispP2 term=NONE cterm=NONE gui=NONE guifg=bisque1
  HiLink lispP3 term=NONE cterm=NONE gui=NONE guifg=bisque2
  HiLink lispP4 term=NONE cterm=NONE gui=NONE guifg=bisque3
  HiLink lispP5 term=NONE cterm=NONE gui=NONE guifg=bisque4
  HiLink lispP6 term=NONE cterm=NONE gui=NONE guifg=chocolate3
  HiLink lispP7 term=NONE cterm=NONE gui=NONE guifg=chocolate4
endif
