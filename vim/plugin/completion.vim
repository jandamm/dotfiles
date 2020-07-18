if exists('g:loaded_completion')
	finish
endif
let g:loaded_completion = 1

set completeopt=menu

function! s:MakeLspSettings() abort
	setlocal omnifunc=lsp#complete
	nnoremap gd :LspDefinition<CR>
endfunction

augroup my_completion
	au!
	" Enable syntaxcomplete if no omnifunc is present
	autocmd Filetype * if &omnifunc == "" | setlocal omnifunc=syntaxcomplete#Complete | endif

	" Enable lsp specific stuff
	autocmd User lsp_buffer_enabled call s:MakeLspSettings()
augroup END
