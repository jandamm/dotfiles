if exists('g:autoloaded_map_leader')
	finish
endif
let g:autoloaded_map_leader = 1

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
	if !s:executed('format')
		call my#format#trim()
		call my#format#reindent()
	endif
endfunction

function! my#map#leader#compile() abort
	if !s:executed('compile')
		call s:undefined('compiler')
	endif
endfunction

function! my#map#leader#run() abort
	if !s:executed('run')
		call s:undefined('run')
	endif
endfunction

function! my#map#leader#test() abort
	if !s:executed('test')
		call s:undefined('test')
	endif
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

function! s:undefined(type) abort
	echohl Error
	echo '{' . a:type . '} is not defined for [' . &filetype . ']'
	echohl NONE
endfunction
