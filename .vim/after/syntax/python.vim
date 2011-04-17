
"syn match Error "^ \{3,}"
syn match Error "^\s\+$"

if exists("python_highlight_builtins")
  syn keyword pythonBuiltin     True False bool self
endif

hi link pythonBuiltin Typedef
hi link pythonException Typedef

syntax sync minlines=200 maxlines=500

