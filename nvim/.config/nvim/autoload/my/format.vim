function! my#format#default() abort
	setlocal tabstop=2 shiftwidth=0 noexpandtab
endfunction

function! my#format#git() abort
	setlocal tabstop=4 shiftwidth=0 noexpandtab
endfunction

function! my#format#trim() abort
	let l:pos = getcurpos()
	call setline(1, map(getline(1,'$'), {k,v -> substitute(v, '\s\+$', '', 'e')}))
	let @/=''
	nohlsearch
	call setpos('.', l:pos)
endfunction

function! my#format#reindent() abort
	let l:pos = getcurpos()
	normal! gg=G
	call setpos('.', l:pos)
endfunction
