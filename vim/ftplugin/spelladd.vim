augroup spellfiles
	au!
	autocmd BufWritePost * :silent mkspell! %
augroup END
