if exists('g:loaded_completion')
	finish
endif
let g:loaded_completion = 1

set completeopt=menu
set infercase

augroup my_completion
	au!
	" Enable syntaxcomplete if no omnifunc is present
	autocmd Filetype * if &omnifunc == "" | setlocal omnifunc=syntaxcomplete#Complete | endif

	" Enable lsp specific stuff
	autocmd User lsp_buffer_enabled setlocal omnifunc=lsp#complete

	" Insert lsp snippet when there is only one match
	autocmd CompleteDone * call timer_start(0, { -> s:on_complete_done() })

	" Insert lsp snippet with ctrlp complete
	autocmd User ctrlp_complete call s:on_ctrlp_complete_done()
augroup END

function s:on_ctrlp_complete_done()
	if &filetype =~? 'swift' | return | endif
	call feedkeys("\<C-x>\<C-o>", 'n')
endfunction
function s:on_complete_done()
	if &completeopt =~# '\v<menuone>' | return | endif
	let info = complete_info(['selected', 'mode'])
	if info.mode ==? 'eval' && info.selected == -2
		call feedkeys(" \<BS>", 'n')
	endif
endfunction
