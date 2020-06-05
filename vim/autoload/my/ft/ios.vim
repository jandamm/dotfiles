if exists('g:autoloaded_ft_ios')
	finish
endif
let g:autoloaded_ft_ios = 1

function! my#ft#ios#build() abort
	wall
	Xbuild
endfunction

function! my#ft#ios#run() abort
	wall
	Xrun
endfunction

function! my#ft#ios#test() abort
	wall
	Xtest
endfunction
