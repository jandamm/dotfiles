if !exists('s:terminals')
	let s:terminals = {}
endif
" TODO: Not reusing buffers from restored sessions
function! my#command#terminal(bang, ...) abort
	let command = a:0 ? a:1 : 'zsh'
	if a:bang
		vsplit
	endif
	if has_key(s:terminals, command) && bufexists(s:terminals[command])
		execute 'buffer '.s:terminals[command]
	else
		execute 'terminal '.command
		let s:terminals[command] = bufnr()
	endif
endfunction

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

function! my#command#substitute_range(l1, l2, search, pat, ...) abort
	let rep = a:0 == 0 ? '' : a:1
	execute a:l1.','.a:l2.'substitute/'.a:search.'/\=substitute(submatch(0),"'.a:pat.'","'.rep.'","g")/g'
endfunction

function! my#command#tree(vertical, ...) abort
	let path = a:0 ? fnamemodify(expand(a:1), ':p') : '.'
	call my#util#temp_buffer(a:vertical)
	call append(0, systemlist('tree ' . path))
endfunction

function! s:error(message) abort
	echohl Error
	echo a:message
	echohl Normal
endfunction
