" my filetype file

if exists("did_load_filetypes")
	"finish
	"somehow i got here
endif

augroup filetypedetect
 au! BufRead,BufNewFile *.doc	setfiletype doxydoc
 au! BufRead,BufNewFile *.t2t	setfiletype txt2tags
 au! BufRead,BufNewFile wiki	setlocal tw=0
 au! BufRead,BufNewFile *.mkd setfiletype mkd | setlocal ai formatoptions=tcroqn2 comments=n:>
augroup END
