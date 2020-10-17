setlocal foldmethod=marker
setlocal foldmarker={{{,}}}

call my#map#apply#tagInclude(':')

augroup vim_linter
	autocmd! * <buffer>
	autocmd BufWritePost <buffer> Lmake! vint
augroup END
