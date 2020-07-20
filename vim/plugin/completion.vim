if exists('g:loaded_completion')
	finish
endif
let g:loaded_completion = 1

set completeopt=menu

augroup my_completion
	au!
	" Enable syntaxcomplete if no omnifunc is present
	autocmd Filetype * if &omnifunc == "" | setlocal omnifunc=syntaxcomplete#Complete | endif

	" Enable lsp specific stuff
	autocmd User lsp_buffer_enabled setlocal omnifunc=lsp#complete

	" Insert lsp snippet when there is only one match
	autocmd CompleteDone * call timer_start(0, { -> s:on_complete_done() })

	" Insert lsp snippet with ctrlp complete
	autocmd User ctrlp_complete call feedkeys("\<C-x>\<C-o>", 'n')
augroup END

function s:on_complete_done()
	if &completeopt =~# 'menuone' | return | endif
	let info = complete_info(['selected', 'items', 'mode'])
	if info.mode ==? 'eval'
				\ && info.selected != -1
				\ && len(info.items) == 1
		call feedkeys(" \<BS>", 'n')
	endif
endfunction
