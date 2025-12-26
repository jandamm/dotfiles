function! my#ft#javascript#format() abort
	call my#ft#javascript#prettierd('1', '$')
endfunction

" Not sure if fragments are working
function! my#ft#javascript#prettierd(l1, l2) abort
	let cursor = getcurpos()
	let range = a:l1 . ',' . a:l2
	let fragment = ''
	" if range !=? '1,$' && range !=? '1,' . line('$')
	"		let fragment = ' --fragment true'
	" endif
	silent execute range . '!prettierd ' . bufname() . fragment
	call setpos('.', cursor)
	echo 1 + a:l2 - a:l1 . ' lines formatted'
endfunction
