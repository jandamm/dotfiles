if exists('g:loaded_diagnostics')
	finish
endif
let g:loaded_diagnostics = 1

let g:lsp_diagnostics_enabled = 0

call neomake#configure#automake('rnw', 500)

let g:neomake_info_sign = {
			\ 'text': 'i',
			\ 'texthl': 'NeomakeInfoSign'
			\ }
