" Vim syntax file
" Language:	Mako Templates
" Last Change:  2007 Jan 22
" Adapted from freemarker and myghty syntax files

" Clear previous syntax settings unless this is v6 or above, in which case just
" exit without doing anything.
if version < 600
    syn clear
elseif exists("b:current_syntax")
    finish
endif

" The HTML syntax file included below uses this variable.
"
if !exists("main_syntax")
    let main_syntax = 'mako'
endif

" First pull in the HTML syntax.
"
"if version < 600
"    so <sfile>:p:h/html.vim
"else
"    runtime! syntax/html.vim
"    unlet b:current_syntax
"endif

"syn cluster htmlPreproc add=@myghtyTop

" Now pull in the Perl syntax.
"
if version < 600
    so <sfile>:p:h/python.vim
else
    syn include @Python syntax/python.vim
endif

" I've not really changed anything here from the mason.vim version, but soon I
" will start altering tags to be more myghty-specific.
" If you have any suggestions, please let me know.
"
syn case match

" directives and interpolations
syn region makoPythonBlock start=/^<%/ end=/%>$/ contains=@Python
syn region makoDef start="<%def" end=">" contains=makoString
syn region makoInherit start="<%inherit" end=">" contains=makoString
syn region makoPage start="<%page" end=">" contains=makoString
syn region makoInclude start="<%include" end=">" contains=makoString
syn region makoNamespace start="<%namespace" end=">" contains=makoString
syn region makoCall start="<%call" end=">" contains=makoString
syn region makoText start="<%text" end=">" contains=makoString
syn region makoConditionalLine matchgroup=Delimiter start="^\s*%" end="$" contains=@Python, makoConditional, makoPythonBlock
syn region makoEndDirective start=+</%+ end=+>+ contains=makoDirective
syn region makoInterpolation start=+${+ end=+}+
syn region makoString contained start=+"+ end=+"+
syn region makoComment start="^#" end="$"

" keywords
syn keyword makoDirective contained def page include namespace inherit call text

" highlighting
highlight link makoPythonBlock Statement
highlight link makoConditionalLine Statement
highlight link makoDef Macro
highlight link makoInherit Macro
highlight link makoPage Macro
highlight link makoInclude Macro
highlight link makoNamespace Macro
highlight link makoCall Macro
highlight link makoText Macro
highlight link makoDirective Macro
highlight link makoEndDirective Macro
highlight link makoStartUserDirective Function
highlight link makoEndUserDirective Function
highlight link makoInterpolation Identifier
highlight link makoString Constant
highlight link makoComment Comment
