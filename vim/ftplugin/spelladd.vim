if exists('g:loaded_spelladd_ftplugin')
	finish
endif
let g:loaded_spelladd_ftplugin = 1

augroup spellfiles
	au!
	autocmd BufWritePost * :silent mkspell! %
augroup END
