":so ~/.vim/syntax2/c.vim

"syn region cTitle contained start=+^ \* +hs=s+2 end=+ --$+he=e-3 oneline
"syn region cNotes contained start=+^ \* +hs=s+2 end=+[Nn]otes:+he=e-1 oneline
"syn region cComment contains=cTitle,cNotes

"syn region cTitle start=+^ \* +hs=s+2 end=+ --$+he=e-3 oneline
"syn region cNotes start=+^ \* +hs=s+2 end=+[Nn]otes:+he=e-1 oneline
"
"hi link cTitle Function
"hi link cNotes Function
"syn region cFunction matchgroup=NONE start=+^\w *\w(.*)$+ end=+^{+me=e-1
"syn region cFunction matchgroup=cType skip="^(\K )?" start="^\K" end="("me=e-1 oneline
"hi cFunction guifg=#23cfda



