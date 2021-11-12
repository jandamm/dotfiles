function textobj#function#swift#select(type) abort
	let initial = getpos('.')

	" Find func keyword
	if !search('\v^[^//]*<func>\C', 'bcW')
		return 0
	endif

	" Set beginning for around
	if a:type ==# 'a'
		let b = getpos('.')
	endif

	" Find beginning of func body
	norm! %
	if !search('\V{', 'W')
		return 0
	endif

	" Set beginning for inside
	if a:type ==# 'i'
		let b = getpos('.')
	endif

	" Find end of body
	norm! %
	let e = getpos('.')

	" Check if initial was in function
	if initial[1] > e[1]
		return 0
	endif

	if a:type ==# 'a'
		return ['V', b, e]

	elseif a:type ==# 'i' && b[1] == e[1] " One line function
		let b[2] += 1
		let e[2] -= 1
		return ['v', b, e]

	elseif a:type ==# 'i'
		let b[1] += 1
		let e[1] -= 1
		return ['V', b, e]
	endif
endfunction
