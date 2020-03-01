if exists('g:autoloaded_util')
	finish
endif
let g:autoloaded_util = 1

function! my#util#highlightGroup() abort
	let l:s = synID(line('.'), col('.'), 1)
	echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfunction
