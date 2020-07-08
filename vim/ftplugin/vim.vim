if exists('g:loaded_vim_ftplugin')
	finish
endif
let g:loaded_vim_ftplugin = 1

augroup vim_asyncomplete_setup
	au!
	autocmd BufEnter *.vim call asyncomplete#enable_for_buffer()
augroup END

call lsp#register_server({
			\ 'name': 'vim-language-server',
			\ 'cmd': {server_info->['vim-language-server', '--stdio']},
			\ 'whitelist': ['vim'],
			\ })
