function! my#map#visualSearch(cmdtype) abort
	let temp = @s
	normal! gv"sy
	let selection = @s
	let @/ = '\V' . substitute(escape(selection, a:cmdtype.'\'), '\n', '\\n', 'g')
	let @s = temp
endfunction

function! my#map#outline() abort
	if &filetype ==? 'man' || &filetype ==? 'help'
		normal! gO
	else
		" Here should buffer tags be loaded into loc/qf list
		" FIXME
	endif
endfunction
