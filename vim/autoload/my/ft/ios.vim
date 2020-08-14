if exists('g:autoloaded_ft_ios')
	finish
endif
let g:autoloaded_ft_ios = 1

function! my#ft#ios#compile() abort
	wall
	silent AbortDispatch xcode
	Xcompiler build
	Make
endfunction

function! my#ft#ios#run() abort
	wall
	silent AbortDispatch xcode
	Xcompiler run
	Make
endfunction

function! my#ft#ios#test() abort
	wall
	silent AbortDispatch xcode
	Xcompiler test
	Make
endfunction
