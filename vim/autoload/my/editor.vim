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

function! my#editor#swap_cmd(bang, l1, l2, ...) abort
	if a:0 != 2 || a:1 == a:2
		call s:error('Need to provide exactly two different words.')
		return
	endif
	try
		let pat = printf((a:bang ? '%s|%s' : '<%s>|<%s>'), a:1, a:2)
		execute a:l1.','.a:l2.'substitute/\v('.pat.')/\={"'.a:2.'":"'.a:1.'","'.a:1.'":"'.a:2.'"}[submatch(1)]/g'
	catch
		call s:error('Could not find any occurence.')
	endtry
endfunction

function! my#editor#tree_cmd(vertical, ...) abort
	let path = a:0 ? fnamemodify(expand(a:1), ':h') : '.'
	call my#util#temp_buffer(a:vertical)
	call append(0, systemlist('tree ' . path))
endfunction

function! s:error(message) abort
	echohl Error
	echo a:message
	echohl Normal
endfunction
