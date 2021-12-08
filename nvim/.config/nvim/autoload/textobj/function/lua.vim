function! s:norm_percent() abort
	" normal %
	call matchit#Match_wrapper('', 1, 'n')
endfunction

function! s:i_oneline(b, e) abort
	call setpos('.', a:b)

	" Find end of params
	if !search('\V)', 'W')
		return 0
	endif

	let b = getpos('.')
	let b[2] += 2
	let a:e[2] -= 1
	return ['v', b, a:e]
endfunction

function textobj#function#lua#select(type) abort
	let initial = getpos('.')

	" Find func keyword
	if !search('\v^[^--]*<function>\C', 'bcW')
		return 0
	endif

	let b = getpos('.')

	" Find end of body
	call s:norm_percent()
	if nvim_get_current_line() =~? '^\s*return'
		call s:norm_percent()
	endif
	let e = getpos('.')

	" Check if initial was in function
	if initial[1] > e[1]
		return 0
	endif

	if a:type ==# 'a'
		return ['V', b, e]

	elseif a:type ==# 'i' && b[1] == e[1] " One line function
		return s:i_oneline(b, e)

	elseif a:type ==# 'i'
		let b[1] += 1
		let e[1] -= 1
		return ['V', b, e]
	endif
endfunction
