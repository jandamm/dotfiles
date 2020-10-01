augroup shell_linter
	autocmd! * <buffer>
	autocmd BufWritePost <buffer> Lmake! shellcheck
augroup END
