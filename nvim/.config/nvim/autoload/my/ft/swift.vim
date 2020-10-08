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

function! my#ft#swift#build() abort
	silent! wall
	let ios = &filetype =~# 'ios' ? 'ios ' : ''
	execute 'Dispatch -compiler=swiftpm neovim swift build '.ios.join(my#ft#swift#compiler_flags(), ' ')
endfunction

" compiler is either swiftpm or make (checked for Makefile).
" errorformat should always be for swiftpm
function! my#ft#swift#compile() abort
	silent! wall
	Make build
endfunction

function! my#ft#swift#run() abort
	silent! wall
	Make run
endfunction

function! my#ft#swift#test() abort
	silent! wall
	Make test
endfunction
