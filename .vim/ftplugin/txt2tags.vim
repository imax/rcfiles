" Vim syntax file
" Filename: txt2tags.vim
" Language: marked text for conversion by txt2tags
" Maintainer: aurélio marinho jargas aurelio@verde666.org
" Last change: 20020822 - changed filename and added instructions
" ---------------------------------------------------------------------
" INFO
"
" - This is the txt2tags VIM syntax file.
" - It's a syntax file just like those for programming languages as C
"   or python, so you know it's handy.
" - Here are registered all the structures defined on the RULES file.
" - When composing your text file, the marks will be highlighted,
"   helping you to quickly make error-free txt2tags files.
" ---------------------------------------------------------------------
" INSTALL (as user)
"
" - Just put in your .vimrc the following line:
"   au BufNewFile,BufRead *.t2t source ~/path/to/txt2tags.vim
"
" - If you want to link the .txt extension to txt2tags also, add:
"   au BufNewFile,BufRead *.txt source ~/path/to/txt2tags.vim
" ---------------------------------------------------------------------
" INSTALL (as superuser)
"
" If you have access to the system configuration, edit the
" /usr/share/vim/vim61/filetype.vim file, adding the following
" lines after the 'Z-Shell script' entry (near the end):
"
"   " txt2tags file
"   au BufNewFile,BufRead *.t2t                 setf txt2tags
"
" And of course, copy the txt2tags.vim file to the
" /usr/share/vim/vim61/syntax/ dir
"


" remove any old syntax stuff hanging around
syn clear
syn sync minlines=500
syn case ignore

syn cluster txtSpecial contains=txtNumber,txtPercent,txtDate,txtImg,txtEmail,txtUrl,txtUrlMark,txtUrlLocal
syn cluster txtBeautifiers contains=txtUnderline,txtItalic,txtBold,txtBoldItalic,txtMonospace

" general
syn match txtList    '^ *[+-] [^ ]'me=e-1
syn match txtDefList '^ *= [^:]\+:' contains=txtDefListId,@txtSpecial,@txtBeautifiers
syn match txtDefListId contained '= \|:'
syn match txtBlank   '\s\+$'
syn match txtBar     '^\s*[_=-]\{20,}\s*$'
syn match txtNumber  '\<\d\+\([,.]\d\+\)\{,1}\>'
syn match txtPercent '\<\d\+\([,.]\d\+\)\{,1}%'

"title things
syn match txtTitleMark contained '^\s*=\+'
syn match txtTitleMark contained '=\+$'
syn match txtTitleMark contained '=\+\['me=e-1,he=e-1
syn match txtTitleRef  contained '\[[^]]*\]$'
syn match txtTitle '^\s*\(=\{1,5}\)[^=].*[^=]\1$'          contains=txtTitleMark
syn match txtTitle '^\s*\(=\{1,5}\)[^=].*[^=]\1\[[^]]*\]$' contains=txtTitleMark,txtTitleRef

"special tags
syn match txtDate '%%date\>\(([^)]*)\)\='
syn match txtImg  '\[[[:alnum:]_,.+%$#@!?+~/-][[:alnum:]_,.+%$#@!?+~/ -]\+\.\(png\|jpe\=g\|gif\|eps\|bmp\)\]'

"syn case match
syn match txtEmail '\<[A-Za-z0-9_.-]\+@\([A-Za-z0-9_-]\+\.\)\+[A-Za-z]\{2,4}\(?[A-Za-z0-9%&=+.@*_-]\+\)\{0,1}\>'
syn match txtUrl   '\<\(\(https\{0,1}\|ftp\|news\|telnet\|gopher\|wais\)://\([A-Za-z0-9._-]\+\(:[^ @]*\)\{0,1}@\)\{0,1}\|\(www[23]\{0,1}\.\|ftp\.\)\)[A-Za-z0-9%._/~:,=-]\+\(#[A-Za-z0-9%._-]\+\|?[A-Za-z0-9/%&=+.@*_-]\+\)\{0,1}\>'
syn match txtUrlLocal contained ' \([A-Za-z0-9%._/~,-]\+\|[A-Za-z0-9%._/~,-]*#[A-Za-z0-9%._-]\+\)\]'ms=s+1,me=e-1
syn match txtUrlMark '\[[^]]* [^] ]\+\]' contains=txtUrlLabel,txtUrl,txtEmail,txtUrlLocal
syn match txtUrlLabel contained '\[[^]]* 'ms=s+1,me=e-1

"underline: a leading/trailing blank makes sense
syn match  txtUnderline  '__[^_].\{-}__'hs=s+2,he=e-2
syn match  txtItalic     '//[^/[:blank:]].\{-}//'hs=s+2,he=e-2
syn match  txtBold       '\*\*[^*[:blank:]].\{-}\*\*'hs=s+2,he=e-2
syn match  txtBoldItalic '\*/[^/[:blank:]].\{-}/\*'hs=s+2,he=e-2
syn match  txtMonospace  "`[^`]*`"hs=s+1,he=e-1

syn region txtPreFormat  start='^---$'hs=s+3 end='^---$'he=e-3
syn match  txtQuote      '^\t\+'

"table
syn match  txtTable      '^ *||\=[<:>]*\s.*' contains=txtTableMark,txtTableTab,txtTableBar,txtTableTit,@txtBeautifiers,@txtSpecial,txtBlank
syn match  txtTableMark  contained '^ *[^\t ]\+'
syn match  txtTableTab contained '\t'
syn match  txtTableBar contained ' |'
syn match  txtTableTit   contained '^ *||.*' contains=txtTableMark,txtTableTab,txtTableBar

syn match txtPre1Line '^--- .*$'hs=s+3
syn match txtComment  '^//.*$'


" color groups
hi link txt_Link     PreProc
hi link txt_Special  Statement
hi link txt_Delim    Identifier
hi link txt_Pre      Type

" color definitions
hi txtBar         term=bold        cterm=bold        gui=bold
hi txtBold        term=bold        cterm=bold        gui=bold
hi txtItalic      term=italic      cterm=italic      gui=italic
hi txtUnderline   term=underline   cterm=underline   gui=underline
hi txtQuote       term=reverse     cterm=reverse     gui=reverse
hi txtBoldItalic  term=bold,italic cterm=bold,italic gui=bold,italic
hi txtComment     ctermfg=brown    guifg=brown
hi txtTableTab    ctermbg=cyan     guibg=cyan

hi link txtTitle      Function
hi link txtBlank      Function
hi link txtNumber     Number
hi link txtPercent    Number
hi link txtUrlMark    txt_Delim
hi link txtUrlLabel   txt_Delim
hi link txtTableTit   txt_Delim
hi link txtTableMark  txt_Delim
hi link txtTableBar   txt_Delim
hi link txtEmail      txt_Link
hi link txtUrl        txt_Link
hi link txtUrlLocal   txt_Link
hi link txtTitleRef   txt_Link
hi link txtDate       txt_Special
hi link txtImg        txt_Special
hi link txtList       txt_Special
hi link txtDefListId  txt_Special
hi link txtDefList    NONE
hi link txtTitleMark  NONE
hi link txtPreFormat  txt_Pre
hi link txtPre1Line   txt_Pre
hi link txtMonospace  txt_Pre

let b:current_syntax = 'txt'
" vim:tw=0:et
