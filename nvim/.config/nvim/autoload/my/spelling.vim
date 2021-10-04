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
		setlocal spellfile=~/.config/nvim/spell/all.utf-8.add,~/.config/nvim/spell/private.utf-8.add,~/.config/nvim/spell/en.utf-8.add
endfunction

function! my#spelling#de() abort
		setlocal spell
		setlocal spelllang=de
		setlocal spellfile=~/.config/nvim/spell/all.utf-8.add,~/.config/nvim/spell/private.utf-8.add,~/.config/nvim/spell/de.utf-8.add
endfunction

function! my#spelling#off() abort
	setlocal nospell
	setlocal spelllang=
	setlocal spellfile=
endfunction
