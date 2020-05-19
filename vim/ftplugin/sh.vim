" if exists('g:loaded_sh_ftplugin')
" 	finish
" endif
" let g:loaded_sh_ftplugin = 1

" if executable('bash-language-server')
	augroup sh_lsp_setup
		au!
		autocmd BufEnter * call asyncomplete#enable_for_buffer()
		autocmd User lsp_setup call lsp#register_server({
					\ 'name': 'bash-language-server',
					\ 'cmd': {server_info->[&shell, &shellcmdflag, 'bash-language-server start']},
					\ 'whitelist': ['sh'],
					\ })
	augroup END
" endif
