if exists('g:autoloaded_editor')
	finish
endif
let g:autoloaded_editor = 1

function! my#editor#winenter() abort
	if getwinvar('%', 'relativenumber', 0) | setlocal relativenumber | endif
	if getwinvar('%', 'cursorline', 0) | setlocal cursorline | endif
	silent! unlet w:relativenumber
	silent! unlet w:cursorline
endfunction

function! my#editor#winleave() abort
	let w:relativenumber = &relativenumber
	let w:cursorline = &cursorline
	setlocal nocursorline norelativenumber
endfunction
