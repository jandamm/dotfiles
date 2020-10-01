setlocal foldmethod=marker
setlocal foldmarker={{{,}}}

augroup vim_linter
	autocmd! * <buffer>
	autocmd BufWritePost <buffer> Lmake! vint
augroup END
