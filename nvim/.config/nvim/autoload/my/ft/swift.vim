function! my#ft#swift#add_compiler_flags(...) abort
	let $NEOVIM_SWIFT_COMPILER_FLAGS .= ' '.join(a:000, ' ')
endfunction

function! my#ft#swift#format() abort
	call my#ft#swift#swiftformat('1', '$')
endfunction

function! my#ft#swift#swiftformat(l1, l2) abort
	let cursor = getcurpos()
	let range = a:l1 . ',' . a:l2
	let fragment = ''
	if range !=? '1,$' && range !=? '1,' . line('$')
		let fragment = ' --fragment true'
	endif
	silent execute range . '!neovim-swiftformat ' . bufname() . fragment
	call setpos('.', cursor)
	echo 1 + a:l2 - a:l1 . ' lines formatted'
endfunction

function! my#ft#swift#build() abort
	silent! wall
	let ios = &filetype =~# 'ios' ? 'ios ' : ''
	execute 'Dispatch -compiler=swiftpm neovim swift build --uniq '.ios
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
