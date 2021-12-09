set completeopt=menu
set infercase

augroup my_completion
	au!
	" Enable syntaxcomplete if no omnifunc is present
	autocmd Filetype * if &omnifunc ==# '' | setlocal omnifunc=syntaxcomplete#Complete | endif
augroup END
