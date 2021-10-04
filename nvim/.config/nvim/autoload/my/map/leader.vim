" Toggle paste-mode and system clipboard
function! my#map#leader#clipboard() abort
	if &paste
		set nopaste
		set clipboard=
	else
		set paste
		set clipboard=unnamed
	endif
endfunction

" If necessary these functions should be overwritten with:
" my#ft#&ft#*()
function! my#map#leader#format() abort
	if s:executed('format') | return | endif

	call my#format#trim()
	call my#format#reindent()
endfunction

function! my#map#leader#compile() abort
	call s:executeOrFail('compile', 'compiler')
endfunction

function! my#map#leader#run() abort
	call s:executeOrFail('run')
endfunction

function! my#map#leader#test() abort
	call s:executeOrFail('test')
endfunction

function! s:executed(func) abort
	for ft in split(&filetype, '\.')
		try
			call my#ft#{ft}#{a:func}()
			return 1
		catch
			continue
		endtry
	endfor
endfunction

function! s:executeOrFail(func, ...) abort
	if s:executed(a:func) | return | endif

	echohl Error
	let compilerName = a:0 ? a:1 : a:func
	echo '{' . compilerName . '} is not defined for [' . &filetype . ']'
	echohl NONE
endfunction
