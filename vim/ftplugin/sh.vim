if exists('g:loaded_sh_ftplugin')
	finish
endif
let g:loaded_sh_ftplugin = 1

call lsp#register_server({
			\ 'name': 'bash-language-server',
			\ 'cmd': {server_info->[&shell, &shellcmdflag, 'bash-language-server start']},
			\ 'allowlist': ['sh'],
			\ })
