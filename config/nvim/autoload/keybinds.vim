function s:deleteNonEmptyLine()
	call setline('.', '')
endfunction

function! keybinds#EnterNewline()
	let l:pos = getcurpos()
	normal! o
	call s:deleteNonEmptyLine()
	call cursor(l:pos[1], l:pos[2])
endfunction

function! keybinds#EnterNewlineAbove()
	let l:pos = getcurpos()
  normal! O
	call s:deleteNonEmptyLine()
	call cursor(l:pos[1] + 1, l:pos[2])
endfunction

function! keybinds#EnterEnter()
	if getline(".") =~ '^\s*\(//\|#\|"\)\s*$'
    return "\<C-u>"
  else
    return "\<CR>"
  endif
endfunction

let g:ulti_expand_or_jump_res = 0 "default value, just set once
" see :h UltiSnips-trigger-functions
function! keybinds#Ulti()
	call UltiSnips#ExpandSnippetOrJump()
	return g:ulti_expand_or_jump_res
endfunction

function! keybinds#SmartTab()
	" Only with tabs enabled
	if &et
		return "\<TAB>"
	else
		" Check if line has only tabs before the cursor
		let l:before = strpart(getline('.'), 0, getcurpos()[2]-1)
		if l:before =~ '^\t*$'
			return "\<TAB>"
		else
			" Insert shiftwidth spaces (max 12)
			return strpart("            ", 0, &shiftwidth)
		endif
	endif
endfunction
