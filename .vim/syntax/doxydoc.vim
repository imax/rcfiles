" Vim syntax file
" Language:	Doxygen input file
" Created:	Max Ischenko <mfi@mail.od.ua>
" Lastchange:	2000 May 10

" Remove any old syntax stuff hanging around
syn clear

set isk+=\\

syn keyword doxyWord \\a \\addindex \\anchor \\arg \\attention \\author \\brief
syn keyword doxyWord \\bug \\c \\class \\code \\date \\def \\defgroup \\deprecated
syn keyword doxyWord \\dontinclude \\endcode \\endhtmlonly \\endif
syn keyword doxyWord \\endlatexonly \\endlink \\endverbatim \\enum \\example
syn keyword doxyWord \\exception \\f$ \\f[ \\f] \\file \\fn \\hideinitializer
syn keyword doxyWord \\htmlonly \\if \\image \\include \\ingroup \\internal
syn keyword doxyWord \\invariant \\latexonly \\li \\line \\link \\mainpage \\name
syn keyword doxyWord \\namespace \\nosubgrouping \\note \\overload \\p \\page \\par
syn keyword doxyWord \\param \\post \\pre \\ref \\relates \\remarks \\return
syn keyword doxyWord \\retval \\sa \\section \\showinitializer \\since \\skip
syn keyword doxyWord \\skipline \\struct \\subsection \\test \\throw \\todo
syn keyword doxyWord \\typedef \\union \\until \\var \\verbatim \\verbinclude
syn keyword doxyWord \\version \\warning 

syn match   doxyWord +\\@+
syn match   doxyWord +\\&+
syn match   doxyWord +\\<+
syn match   doxyWord +\\>+
syn match   doxyWord +\\#+
syn match   doxyWord +\\\$+
syn match   doxyWord +\\\\+

syn region  doxyItalicWord matchgroup=doxyWord start="\\e " end="\(\s\|[.!?]\)"he=e-1 oneline
syn region  doxyBoldWord matchgroup=doxyWord start="\\b " end="\(\s\|[.!?]\)"he=e-1 oneline

if !exists("did_doxygen_syntax_inits")
  let did_doxygen_syntax_inits = 1
  hi link doxyWord Statement
  hi doxyBoldWord gui=bold term=bold cterm=bold
  hi doxyItalicWord gui=underline term=underline cterm=underline
endif

let b:current_syntax = "doxydoc"

