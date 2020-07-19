if exists('g:autoloaded_keybinds')
	finish
endif
let g:autoloaded_keybinds = 1

function! my#keybinds#visualSearch(cmdtype) abort
	let temp = @s
	normal! gv"sy
	let selection = @s
	let @/ = '\V' . substitute(escape(selection, a:cmdtype.'\'), '\n', '\\n', 'g')
	let @s = temp
endfunction

function! my#keybinds#gO() abort
	if &filetype ==? 'man' || &filetype ==? 'help'
		normal! gO
	else
		TagbarToggle
	endif
endfunction

function! s:deleteNonEmptyLine() abort
	call setline('.', '')
endfunction
function! s:matchesCommentsOrWhitespace(input) abort
	return a:input =~? '^\s\+$' || s:matchesComments(a:input, 1)
endfunction

function! s:matchesComments(input, ...) abort
	let l:match = '^\s*\(//\+\|#\|"\)\s*'
	if a:0 == 0 || a:1 == 1
		let l:match .= '$'
	endif
	return a:input =~? l:match
endfunction

function! s:shiftwidthSpaces(charcount) abort
	if &expandtab
		return "\<TAB>"
	else
		let toNextTabstop = float2nr(&shiftwidth - fmod(a:charcount, &shiftwidth))
		return repeat(' ', toNextTabstop)
	endif
endfunction

function! my#keybinds#EnterNewline() abort
	let l:pos = getcurpos()
	normal! o
	call s:deleteNonEmptyLine()
	call cursor(l:pos[1], l:pos[2])
endfunction

function! my#keybinds#EnterNewlineAbove() abort
	let l:pos = getcurpos()
	normal! O
	call s:deleteNonEmptyLine()
	call cursor(l:pos[1] + 1, l:pos[2])
endfunction

function! my#keybinds#EnterEnter() abort
	if pumvisible()
		return "\<C-y>"
	elseif s:matchesCommentsOrWhitespace(getline('.'))
		return "\<C-u>"
	elseif exists('*EndwiseDiscretionary')
		return "\<CR>\<C-r>=EndwiseDiscretionary()\<CR>"
	else
		return "\<CR>"
	endif
endfunction

function! my#keybinds#SmartTab() abort
	if pumvisible()
		return "\<C-n>"
	else
		let l:before = strpart(getline('.'), 0, col('.') - 1)
		if l:before ==? '' || l:before =~? '\t$'
			return "\<TAB>"
		elseif s:matchesComments(l:before, 0) || l:before =~? '\s$'
			return s:shiftwidthSpaces(len(l:before))
		else
			return "\<C-x>\<C-o>"
		endif
	endif
endfunction

function! my#keybinds#Spell() abort
	if !&spell                 " Off -> US
		call my#spelling#en()
	elseif &spelllang =~? 'en' " US -> DE
		call my#spelling#de()
	else                       " DE -> Off
		call my#spelling#off()
	endif
endfunction
