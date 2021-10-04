function! my#ft#swift#add_compiler_flags(...) abort
	let $NEOVIM_SWIFT_COMPILER_FLAGS .= ' '.join(a:000, ' ')
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
	execute 'Dispatch -compiler=swiftpm neovim swift build '.ios
endfunction

function! my#ft#swift#compile() abort
	silent! wall
	call s:set_compiler()
	Make build
endfunction

function! my#ft#swift#run() abort
	silent! wall
	call s:set_compiler()
	Make run
endfunction

function! my#ft#swift#test() abort
	silent! wall
	call s:set_compiler()
	Make test
endfunction

function! s:set_compiler() abort
	compiler swiftpm
	if exists('b:uses_make')
		set makeprg=make
	endif
endfunction
