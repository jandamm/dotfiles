set completeopt=menu
set infercase

augroup my_completion
	au!
	" Enable syntaxcomplete if no omnifunc is present
	autocmd Filetype * if &omnifunc ==# '' | setlocal omnifunc=syntaxcomplete#Complete | endif

	" Insert lsp snippet when there is only one match
	autocmd User LSCOnChangesFlushed if &omnifunc ==# 'lsc#complete#complete' | setlocal omnifunc=LSCOmniWrapper | endif

augroup END

function! LSCOmniWrapper(a, b) abort
	let results = lsc#complete#complete(a:a, a:b)
	if !(&completeopt =~# '\v<(menuone|noinsert)>')
		call timer_start(0, { -> s:expand_single_complete_entry() })
	endif
	return results
endfunction

function s:expand_single_complete_entry()
	if complete_info(['selected']).selected == -2
		call feedkeys(" \<BS>", 'n')
	endif
endfunction
