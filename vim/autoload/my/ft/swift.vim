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

" TODO: Add compiler swiftpm
function! my#ft#swift#compile() abort
	wall
	Dispatch swift build
endfunction

function! my#ft#swift#run() abort
	wall
	Dispatch swift run
endfunction

function! my#ft#swift#test() abort
	wall
	Dispatch swift test
endfunction
