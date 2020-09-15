if exists('g:autoloaded_my_commands') | finish | endif
let g:autoloaded_my_commands = 1

function! my#command#swap(bang, l1, l2, ...) abort
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

function! my#command#tree(vertical, ...) abort
	let path = a:0 ? fnamemodify(expand(a:1), ':h') : '.'
	call my#util#temp_buffer(a:vertical)
	call append(0, systemlist('tree ' . path))
endfunction

function! s:error(message) abort
	echohl Error
	echo a:message
	echohl Normal
endfunction