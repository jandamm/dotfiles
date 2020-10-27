if exists('g:autoloaded_my_lint')
	finish
endif
let g:autoloaded_my_lint = 1

augroup my_linter | augroup END

function! my#lint#setup(linter, ...) abort
	autocmd! my_linter * <buffer>
	let open = a:0 && a:1 ? ' ' : '! '
	execute 'autocmd my_linter BufWritePost <buffer> Lmake'.open.a:linter
endfunction
