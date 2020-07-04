if exists('g:loaded_diagnostics')
	finish
endif
let g:loaded_diagnostics = 1

let g:lsp_diagnostics_enabled = 0

augroup neomake_startup
	au!
	autocmd Filetype * ++once call neomake#configure#automake('rnw', 500)
augroup END

let g:neomake_info_sign = {
			\ 'text': 'i',
			\ 'texthl': 'NeomakeInfoSign'
			\ }
let g:neomake_message_sign = g:neomake_info_sign
