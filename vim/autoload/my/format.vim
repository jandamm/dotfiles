if exists('g:autoloaded_format')
	finish
endif
let g:autoloaded_format = 1

function! my#format#default() abort
	set tabstop=2
	set shiftwidth=2
	set noexpandtab
endfunction

function! my#format#git() abort
	set tabstop=4
	set shiftwidth=4
	set noexpandtab
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
