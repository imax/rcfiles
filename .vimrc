
set background=dark
:so ~/.vim/.vimrc
if has("gui_running")
 :so ~/.vim/.gvimrc
 set guifont=Menlo:h14
 nmap <D-Left> :bp<cr>
 nmap <D-Right> :bn<cr>
endif

