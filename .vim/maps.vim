"
" "Global mappings and commands."
" Make sure that right <LocalLeader> was setup in vimrc file.
"
" Disable built-in F1 key (help)
:nmap <F1> :echo<CR>
:imap <F1> <C-o>:echo<CR>

noremap <C-TAB> :bnext<CR>
inoremap <C-TAB> <ESC>:bnext<CR>i
noremap <C-S-TAB> :bprevious<CR>
inoremap <C-S-TAB> <ESC>:bprevious<CR>i
nnoremap Q <nop>

" Buffer navigation {{{1
nmap <F2> :update<CR>
imap <F2> <C-o>:update<CR>
nmap <C-F2> :w!<CR>
"nmap <F5> :e<CR>
nmap <F8> :bd<CR>
"nmap <F10> :qa!<CR>
nmap <C-p> :bp<CR>
nmap <C-n> :bn<CR>
nmap <C-Right> :bn<CR>
nmap <C-Left> :bp<CR>
nmap <M-Right> :cn<CR>
nmap <M-Left> :cp<CR>
nmap <M-CR> :cl<CR>
nmap <S-CR> i_<Esc>r

" Command mode mappings {{{1
" Set cmd-line emacs-like bindings
" start of line
:cnoremap <C-A>  <Home>
" back one character
:cnoremap <C-B>  <Left>
" delete character under cursor
":cnoremap <C-D>  <Del>
" end of line
:cnoremap <C-E>  <End>
" forward one character
:cnoremap <C-F>  <Right>
" recall newer command-line
:cnoremap <C-N>  <Down>
" recall previous (older) command-line
:cnoremap <C-P>  <Up>
" back one word
:cnoremap <Esc><C-B> <S-Left>
" forward one word
:cnoremap <Esc><C-F> <S-Right>
" Paste clipboard contents to cmdline
:cnoremap <S-Insert> <C-R>*
cmap <C-T> e <C-R>=expand("%:r")<CR>.
" Next identical line
nmap gl 0y$/<C-r>"<CR>

" Insert mode mappings {{{1
" Literally insert clipboard contents (Built-in since vim6.0at)
"imap <S-Insert> <C-R><C-O>*
"imap <C-V> <C-R><C-o>*
" Reformat the paragraph
imap <C-J> <C-O>gqap
imap <C-Del> <C-O>cw
" Completition shortcuts
:inoremap ^L ^X^L
imap <S-Up> <C-o><C-E>
imap <S-Down> <C-o><C-Y>
imap <F6> <C-o>:b#<CR>

" Normal mode mappings {{{1
nmap <D-Left> :bp
nmap <D-Right> :bn
nmap <F6> :b#<CR>
nmap <silent> <M-Down> :call ScrollOtherWindow("down")<CR>
nmap <silent> <M-Up> :call ScrollOtherWindow("up")<CR>
nmap Y y$
nmap <LocalLeader>p :set patchmode=.orig<CR>
nmap <LocalLeader>v :e ~/.vim/.vimrc<CR>
nmap <LocalLeader>m :e ~/.vim/maps.vim<CR>
map <leader>t :FuzzyFinderTextMate<CR>
map <leader>b :FuzzyFinderBuffer<CR>
noremap <space> :call ToggleFold()<CR>
nmap gj o<ESC>k
nmap gk O<ESC>j
nmap <silent> <leader>s :set nolist!<CR>
" commentify-compat
nmap ,x ,c<space>
nmap <c-space> ,c<space>
vmap <c-space> ,c<space>

" Unsorted stuff {{{1
" nmap <C-space> .foldclose
"au BufWritePost *.html !netscape -remote 'openURL(file:%:p)<CR>
"
if !has("gui_running")
" Rxvt uses wrong escape codes for cursor keys (or I made it to)
" Basic fixes.
 map [1~ 0
 map [4~ $
endif
" Visual mode mappings {{{1
" Make p in Visual mode replace the selected text with the "" register.
vnoremap p <Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>
vmap * y/<C-r>"<CR>

" Command-line mode mappings {{{1
cmap <C-E> e <C-R>=expand("%:p:h")<CR>/

" Transfer text fragments between different Vim sessions {{{1
nmap \xr   :r $HOME/.vimxfer<CR>
nmap \xw   :'a,.w! $HOME/.vimxfer<CR>
vmap \xr   c<esc>:r $HOME/.vimxfer<CR>
vmap \xw   :w! $HOME/.vimxfer<CR>

" Helper functions to be used in mappings {{{1
"
" Toggle fold state between closed and opened. {{{2
"
" If there is no fold at current line, just move forward.
fun! ToggleFold()
	if foldlevel('.') == 0
		normal! l
	else
		if foldclosed('.') < 0
			. foldclose!
		else
			. foldopen!
		endif
	endif
	" Clear status line
	echo
endfun

" Scroll alternate window by one line. {{{2
" TODO: supply number of lines to scroll.
fun! ScrollOtherWindow(dir)
	if a:dir == "down"
		let move = "\<C-E>"
	elseif a:dir == "up"
		let move = "\<C-Y>"
	endif
	exec "normal \<C-W>p" . move . "\<C-W>p"
endfun

" Eat next char from input. Used by Iabbr {{{2
fun! Eatchar(pat)
   let c = getchar()
   if c != 0
     let c = nr2char(c)
   endif
   return (c =~ a:pat) ? '' : c
endfun

" Sets file's executable permission bit. {{{2
fun! SetExecutableBit()
	let fname = expand("%:p")
	:checktime
	exec "au FileChangedShell " . fname . " :echo"
	:silent !chmod a+x %
	:checktime
	exec "au! FileChangedShell " . fname
endfun

" }}}
