if exists('g:autoloaded_my_helper')
	finish
endif
let g:autoloaded_my_helper = 1

function! my#map#apply#tagInclude(chars) abort
	let chars = escape(a:chars, '"')
	for key in ['<C-]>', '<C-w>]', '<C-w><C-]>', 'g]', '<C-W>g]', 'g<C-]>', '<C-W>g<C-]>', '<C-x><C-]>']
		execute 'nnoremap <silent> <buffer> '.key.' :call my#util#oneShotSet("isk","+=","'.chars.'")<CR>'.key
	endfor
endfunction
