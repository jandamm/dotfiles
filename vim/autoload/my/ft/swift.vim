if exists('g:autoloaded_ft_swift')
	finish
endif
let g:autoloaded_ft_swift = 1

function! my#ft#swift#format(path) abort
	let cursor = getcurpos()
	silent execute '0,$!neomake-swiftformat ' . a:path
	call setpos('.', cursor)
	echo line('$') . ' lines formatted'
endfunction
