augroup spellfiles
	autocmd! * <buffer>
	autocmd BufWritePost <buffer> silent mkspell! %
augroup END
