if exists('g:autoloaded_ft_ios')
	finish
endif
let g:autoloaded_ft_ios = 1

function! my#ft#ios#compile() abort
	wall
	AbortDispatch
	Xcompiler build
	Make
endfunction

function! my#ft#ios#run() abort
	wall
	AbortDispatch
	Xcompiler run
	Make
endfunction

function! my#ft#ios#test() abort
	wall
	AbortDispatch
	Xcompiler test
	Make
endfunction
