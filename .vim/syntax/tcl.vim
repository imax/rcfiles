" -*- vim -*-
" Language:	tcl/tk
" FILE: "/home/max/.vim/syntax/tcl.vim" {{{
" Last Change:	Fri, 24 Nov 2000 16:49:51 +0200
" Maintainer:	Max Ischenko, <ischenko@ukr.net>
" $Id: tcl.vim,v 1.2 2001/07/23 07:43:17 max Exp $ }}}

" Remove any old syntax stuff hanging around
syn clear
set comments=:#
" A bunch of useful keywords
syn keyword tclCommand return lindex llength lappend lreplace lsort 
syn keyword tclCommand lrange list lsearch lreplace
syn keyword tclCommand concat incr set memory append after
syn keyword tclCommand case array update unset unknown trace time in
syn keyword tclCommand tell socket seek open close read write scan
syn keyword tclCommand if then else elseif switch subst string split source
syn keyword tclCommand regsub regexp registry pwd puts pid package namespace
syn keyword tclCommand load linsert join interp info glob gets format binary
syn keyword tclCommand flush file fileevent fcopy fconfigure fblocked bgerror
syn keyword tclCommand expr exit eval error eof encoding dde clock cd catch
syn keyword tclCommand while for foreach break continue rename
syn keyword tclCommand vwait default variable global upvar uplevel
syn keyword tclVars	env errorCode errorInfo tcl_library tcl_patchLevel 
syn keyword tclVars	tcl_pkgPath tcl_platform tcl_precision tcl_rcFileName
syn keyword tclVars	tcl_rcRsrcName tcl_traceCompile tcl_traceExec tcl_version
syn keyword tclVars	tk_library tk_patchLevel tkPriv tk_strictMotif tk_version
syn keyword tkCommand	bell bind bindtags button canvas checkbutton clipboard 
syn keyword tkCommand	destroy entry event focus font frame
syn keyword tkCommand	grab grid image 
syn keyword tkCommand	label listbox lower menu menubar menubutton message
syn keyword tkCommand	option pack place radiobutton raise
syn keyword tkCommand	scale scrollbar selection send text
syn keyword tkCommand	tk tkwait tkerror toplevel winfo wm
syn keyword tkCommand	tk_setPalette tk_bisque tk_popup tk_optionMenu
syn keyword tkCommand	tk_messageBox tk_menuBar tk_bindForTraversal
syn keyword tkCommand	tk_getOpenFile tk_getSaveFile tk_focusNext tk_dialog
syn keyword tkCommand	tk_focusPrev tk_focusFollowsMouse tk_chooseColor
"syn keyword tcltkSwitch	contained	insert create polygon fill outline tag

syn match tclVariable "\$[a-zA-Z_0-9]\+"
" String and Character contstants
" Highlight special characters (those which have a backslash) differently
syn match   tclSpecial contained "\\\d\d\d\=\|\\."
" A string needs the skip argument as it may legitimately contain \".
" Match at start of line
syn region  tclString		  start=+^"+ end=+"+ contains=tclSpecial skip=+\\\\\|\\"+
"Match all other legal strings.
syn region  tclString		  start=+[^\\]"+ms=s+1  end=+"+ contains=tclSpecial,tclVariable skip=+\\\\\|\\"+

syn match   tclLineContinue "\\\s*$"

"integer number, or floating point number without a dot and with "f".
syn case ignore
syn match  tclNumber		"\<\d\+\(u\=l\=\|lu\|f\)\>"
"floating point number, with dot, optional exponent
syn match  tclNumber		"\<\d\+\.\d*\(e[-+]\=\d\+\)\=[fl]\=\>"
"floating point number, starting with a dot, optional exponent
syn match  tclNumber		"\.\d\+\(e[-+]\=\d\+\)\=[fl]\=\>"
"floating point number, without dot, with exponent
syn match  tclNumber		"\<\d\+e[-+]\=\d\+[fl]\=\>"
"hex number
syn match  tclNumber		"0x[0-9a-f]\+\(u\=l\=\|lu\)\>"
"syn match  tclIdentifier	"\<[a-z_][a-z0-9_]*\>"
syn case match

syn keyword tclTodo contained	TODO XXX FIXME NOTE
syn region tclTitle contained start=+^# +hs=s+2 end=+--$+he=e-3 oneline
"syn region tclTitle start="a" end="c" oneline
syn region tclComment		start="^\#" end="$" contains=tclTodo,tclTitle
syn region tclComment		start=/;\s*\#/hs=s+1 end="$" contains=tclTodo

syn region tclFunction matchgroup=tclCommand start=+proc + end=+ +he=e-1 oneline
syn region tclFunction matchgroup=tclCommand start=+test + end=+ +he=e-1 oneline
"syn region tclCmd matchgroup=tclCommand start=+\w\++ end=+$+ oneline
syn match tclBindKey "<\(\w\|-\)\+>" contains=tclVariable
syn match tclSwitch "\s-\a\+"ms=s+1
"syn region tclBindCmd start="bind"

"syn sync ccomment tclComment

hi link tclNumber         Number
hi link tclFunction       Function
hi link tclCommand        Statement
hi link tkCommand         Statement
hi link tclSwitch         Type
hi link tclString         String
hi link tclComment        Comment
hi link tclSpecial        Special
hi link tclTodo           Todo
hi link tclTitle          Function
hi link tclVariable       Function
hi link tclLineContinue   WarningMsg
hi link tclVars           Special
hi link tclBindKey        Special

let b:current_syntax = "tcl"

" vim: tw=0:nowrap:
