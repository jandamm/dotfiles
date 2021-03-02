if exists('g:autoloaded_my_commands')
	finish
endif
let g:autoloaded_my_commands = 1

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

function! my#command#lmake(bang, win, ...) abort
	call s:make('l', a:bang, a:win, a:0 ? a:1 : '')
endfunction

function! my#command#amake(bang, win, ...) abort
	call s:make('c', a:bang, a:win, a:0 ? a:1 : '')
endfunction

function! s:make(prefix, bang, win, compiler) abort
	if !empty(a:compiler)
		execute 'compiler '.a:compiler
	endif
	augroup lmake_lwindow
		autocmd!
		call my#asyncdo#openListIf(!a:bang, a:prefix)
	augroup END

	" Replace % with filename
	let bufnr = winbufnr(a:win)
	let makeprg = bufnr > 0 ? substitute(&makeprg, '\V%', bufname(bufnr), 'g') : &makeprg
	silent call my#asyncdo#stopAndRun(a:prefix, a:win, 1, { 'job': makeprg, 'errorformat': &errorformat})
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
