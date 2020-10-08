call my#spelling#en()

augroup markdown_linter
	autocmd! * <buffer>
	autocmd BufWritePost <buffer> Lmake! markdownlint
augroup END
