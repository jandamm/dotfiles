if exists('g:loaded_diagnostics')
	finish
endif
let g:loaded_diagnostics = 1

let g:lsp_diagnostics_enabled = 0

function! s:MakeLspSettings() abort
	if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif

	nmap <buffer> gd <Plug>(lsp-definition)
	nmap <buffer> gr <Plug>(lsp-references)
	nmap <buffer> gi <Plug>(lsp-implementation)
	nmap <buffer> gt <Plug>(lsp-type-definition)
	nmap <buffer> [g <Plug>(lsp-previous-diagnostic)
	nmap <buffer> ]g <Plug>(lsp-next-diagnostic)
	nmap <buffer> K  <Plug>(lsp-hover)

	" Not sure how to integrate yet
	" nmap <buffer> <leader>rn <plug>(lsp-rename)
endfunction

augroup my_diagnostics
	au!
	autocmd Filetype * ++once call neomake#configure#automake('rnw', 500)
	autocmd Filetype qf nmap <buffer> q :q<CR>
	autocmd User lsp_buffer_enabled call s:MakeLspSettings()
augroup END

let g:neomake_info_sign = {
			\ 'text': 'i',
			\ 'texthl': 'NeomakeInfoSign'
			\ }
let g:neomake_message_sign = g:neomake_info_sign
