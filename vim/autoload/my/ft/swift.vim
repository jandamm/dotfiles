function! my#ft#swift#format(path) abort
	let cursor = getcurpos()
	execute '0,$!neomake-swiftformat ' . a:path
	call setpos('.', cursor)
endfunction
