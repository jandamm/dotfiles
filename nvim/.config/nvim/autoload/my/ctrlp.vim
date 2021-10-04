function! my#ctrlp#match(lines, input, limit, mmode, ispath, crfile, regex) abort
	if a:regex
		return s:ctrlp_regex_match(a:lines, a:input, a:mmode)
	else
		return cpsm#CtrlPMatch(a:lines, a:input, a:limit, a:mmode, a:ispath, a:crfile, a:regex)
	endif
endfunction

" Copied from ctrlp_cmatcher

function! s:ctrlp_regex_match(lines, input, mmode) abort
	let array = []
	let func = a:mmode ==? 'filename-only' ? 's:matchfname' : 'match'
	for item in a:lines
		if call(func, [item, a:input]) >= 0
			call add(array, item)
		endif
	endfor
	call sort(array, ctrlp#call('s:mixedsort'))
	call s:highlight_regex(a:input, a:mmode)
	return array
endfunction

function! s:matchfname(item, pat) abort
	let parts = split(a:item, '[\/]\ze[^\/]\+$')
	return match(parts[-1], a:pat)
endfunction

function! s:highlight_regex(input, mmode) abort
	" highlight matches
	call clearmatches()
	let pat = ''
	if a:mmode ==? 'filename-only'
		let pat = substitute(a:input, '\$\@<!$', '\\ze[^\\/]*$', 'g')
	endif
	if empty(pat)
		let pat = substitute(a:input, '\\\@<!\^', '^> \\zs', 'g')
	endif
	call matchadd('CtrlPMatch', '\c'.pat)
endfunction
