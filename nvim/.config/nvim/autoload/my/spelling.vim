if exists('g:autoloaded_spelling')
	finish
endif
let g:autoloaded_spelling = 1

function! my#spelling#toggle() abort
	if !&spell                 " Off -> US
		call my#spelling#en()
	elseif &spelllang =~? 'en' " US -> DE
		call my#spelling#de()
	else                       " DE -> Off
		call my#spelling#off()
	endif
endfunction

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
