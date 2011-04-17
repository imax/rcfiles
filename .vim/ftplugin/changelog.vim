
augroup ChangeLog
au!
au BufNew,BufNewFile,BufRead *ChangeLog :call <SID>AddNewEntry()<CR>
augroup end

fun! s:AddNewEntry()
	:normal gg
	:append
''DATE'': MaxIschenko
  * 	
.
  :%s/DATE/<C-R>=strftime("%Y-%b-%d")<CR>
endfun

