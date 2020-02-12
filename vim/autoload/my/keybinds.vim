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
		let l:spaces = ''
		let l:toNextTabstop = float2nr(&shiftwidth - fmod(a:charcount, &shiftwidth))
		for i in range(1, l:toNextTabstop)
			let l:spaces .= ' '
		endfor
		return l:spaces
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

let g:ulti_expand_or_jump_res = 0 "default value, just set once
" see :h UltiSnips-trigger-functions
function! my#keybinds#UltiExpandOrJump() abort
	call UltiSnips#ExpandSnippetOrJump()
	return g:ulti_expand_or_jump_res
endfunction

function! my#keybinds#SmartTab() abort
	if pumvisible()
		return "\<C-n>"
	else
		" Check if line has only tabs before the cursor
		let l:before = strpart(getline('.'), 0, getcurpos()[2] - 1)
		if l:before =~? '^\t*$'
			return "\<TAB>"
		elseif s:matchesComments(l:before, 0)
					\ || l:before =~? '\s$'
			return s:shiftwidthSpaces(len(l:before))
		elseif b:asyncomplete_enable
			return asyncomplete#force_refresh()
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
