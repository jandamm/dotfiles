function! my#spelling#setSpellfile() abort
	if !&spell
		setlocal spellfile=
	else
		let l:lang = strcharpart(&spelllang, 0, 2)
		let l:defa = '~/.vim/spell/all.utf-8.add,~/.vim/spell/private.utf-8.add'
		if len(l:lang) == 2
			let &l:spellfile = l:defa . ',~/.vim/spell/' . l:lang . '.utf-8.add'
		else
			let &l:spellfile = l:defa
		endif
	endif
endfunction

function! my#spelling#en() abort
		setlocal spell
		setlocal spelllang=en_us
		call my#spelling#setSpellfile()
endfunction

function! my#spelling#de() abort
		setlocal spell
		setlocal spelllang=de
		call my#spelling#setSpellfile()
endfunction

function! my#spelling#off() abort
	setlocal nospell
	setlocal spelllang=
	call my#spelling#setSpellfile()
endfunction
