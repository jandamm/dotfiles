augroup vim_asyncomplete_setup
	au!
	autocmd User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#necovim#get_source_options({
				\ 'name': 'necovim',
				\ 'whitelist': ['vim'],
				\ 'completor': function('asyncomplete#sources#necovim#completor'),
				\ }))
augroup END

