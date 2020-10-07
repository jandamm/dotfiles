setlocal foldmethod=marker
setlocal foldmarker={{{,}}}

nnoremap <silent> <buffer>  <C-]> :call my#util#oneShotSet('isk','+=',':')<CR><C-]>
nnoremap <silent> <buffer> g<C-]> :call my#util#oneShotSet('isk','+=',':')<CR>g<C-]>

augroup vim_linter
	autocmd! * <buffer>
	autocmd BufWritePost <buffer> Lmake! vint
augroup END
