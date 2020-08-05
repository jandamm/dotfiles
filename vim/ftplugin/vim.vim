if exists('g:loaded_vim_ftplugin')
	finish
endif
let g:loaded_vim_ftplugin = 1

call lsp#register_server({
			\ 'name': 'vim-language-server',
			\ 'cmd': {server_info->['vim-language-server', '--stdio']},
			\ 'allowlist': ['vim'],
			\ })
