if exists('g:autoloaded_map_leader')
	finish
endif
let g:autoloaded_map_leader = 1

" If necessary these functions should be overwritten with:
" my#ft#&ft#*()
function! my#map#leader#format() abort
	try
		call my#ft#{&ft}#format()
	catch
		call my#format#trim()
		call my#format#reindent()
	endtry
endfunction

function! my#map#leader#compile() abort
	try
		call my#ft#{&ft}#compile()
	catch
		echo s:undefined('compiler')
	endtry
endfunction

function! my#map#leader#run() abort
	try
		call my#ft#{&ft}#run()
	catch
		echo s:undefined('run')
	endtry
endfunction

function! my#map#leader#test() abort
	try
		call my#ft#{&ft}#test()
	catch
		echo s:undefined('test')
	endtry
endfunction

function! s:undefined(type) abort
	return '{' . a:type . '} is not defined for [' . &filetype . ']'
endfunction
