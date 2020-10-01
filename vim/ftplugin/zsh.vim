augroup shell_linter
	autocmd! * <buffer>
	autocmd BufWritePost <buffer> Lmake shell
augroup END
