if exists('g:autoloaded_ft_swift')
	finish
endif
let g:autoloaded_ft_swift = 1

function! my#ft#swift#format() abort
	call my#ft#swift#swiftformat('%')
endfunction

function! my#ft#swift#swiftformat(path) abort
	let cursor = getcurpos()
	silent execute '0,$!neomake-swiftformat ' . a:path
	call setpos('.', cursor)
	echo line('$') . ' lines formatted'
endfunction

function! my#ft#swift#compile() abort
	wall
	TermDo swift build
endfunction

function! my#ft#swift#run() abort
	wall
	TermDo swift run
endfunction

function! my#ft#swift#test() abort
	wall
	TermDo swift test
endfunction
