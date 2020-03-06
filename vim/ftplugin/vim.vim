if exists('g:loaded_vim_ftplugin')
	finish
endif
let g:loaded_vim_ftplugin = 1

augroup vim_asyncomplete_setup
	au!
	autocmd BufEnter *.vim call asyncomplete#enable_for_buffer()
	autocmd User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#necovim#get_source_options({
				\ 'name': 'necovim',
				\ 'whitelist': ['vim'],
				\ 'completor': function('asyncomplete#sources#necovim#completor'),
				\ }))
augroup END

