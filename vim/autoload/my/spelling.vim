if exists('g:autoloaded_spelling')
	finish
endif
let g:autoloaded_spelling = 1

function! my#spelling#en() abort
		setlocal spell
		setlocal spelllang=en_us
		setlocal spellfile=~/.vim/spell/all.utf-8.add,~/.vim/spell/private.utf-8.add,~/.vim/spell/en.utf-8.add
endfunction

function! my#spelling#de() abort
		setlocal spell
		setlocal spelllang=de
		setlocal spellfile=~/.vim/spell/all.utf-8.add,~/.vim/spell/private.utf-8.add,~/.vim/spell/de.utf-8.add
endfunction

function! my#spelling#off() abort
	setlocal nospell
	setlocal spelllang=
	setlocal spellfile=
endfunction
