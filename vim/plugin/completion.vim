if exists('g:loaded_completion_plugin')
	finish
endif
let g:loaded_completion_plugin = 1

function! s:MakeLspSettings() abort
	nnoremap gd :LspDefinition<CR>
endfunction

function! s:DisableAutoAsyncomplete(...) abort
	if pumvisible() == 0
		let g:asyncomplete_auto_popup = 0
		call timer_start(1000, function('s:ResetCompleteopt'))
	endif
endfunction

function! s:ResetCompleteopt(...) abort
	if pumvisible() == 0
		setlocal completeopt=menu,preview
	endif
endfunction

augroup my_completion
	au!
	" Enable syntaxcomplete if no omnifunc is present
	autocmd Filetype * if &omnifunc == "" | setlocal omnifunc=syntaxcomplete#Complete | endif

	" Enable lsp specific stuff
	autocmd User lsp_buffer_enabled call s:MakeLspSettings()

	" Disable asyncomplete after completion
	" The timer is needed as CompleteDone is called but the pum would reappear directly afterwards.
	autocmd CompleteDone * call timer_start(200, function('s:DisableAutoAsyncomplete'))
	autocmd InsertLeave * let g:asyncomplete_auto_popup = 0
augroup END
