if exists('g:autoloaded_ft_swift')
	finish
endif
let g:autoloaded_ft_swift = 1

function! my#ft#swift#compiler_flags() abort
	return get(b:, 'swift_compiler_flags', []) + get(g:, 'swift_compiler_flags', [])
endfunction

function! my#ft#swift#format() abort
	call my#ft#swift#swiftformat('%')
endfunction

function! my#ft#swift#swiftformat(path) abort
	let cursor = getcurpos()
	silent execute '0,$!neovim-swiftformat ' . a:path
	call setpos('.', cursor)
	echo line('$') . ' lines formatted'
endfunction

" TODO: Add compiler swiftpm
function! my#ft#swift#compile() abort
	silent! wall
	Dispatch swift build
endfunction

function! my#ft#swift#run() abort
	silent! wall
	Dispatch swift run
endfunction

function! my#ft#swift#test() abort
	silent! wall
	Dispatch swift test
endfunction
