function! my#map#key#enter() abort
	" cmp will capture <CR> if cmp is active.
	if s:matchesCommentsOrWhitespace(getline('.'))
		return "\<C-u>"
	elseif exists('*EndwiseDiscretionary')
		return "\<CR>\<C-r>=EndwiseDiscretionary()\<CR>"
	else
		return "\<CR>"
	endif
endfunction

function! my#map#key#tab() abort
	let l:before = strpart(getline('.'), 0, col('.') - 1)
	if luasnip#expandable()
		return "\<Plug>luasnip-expand-snippet"
	elseif luaeval('require"cmp".visible()')
		return "\<Plug>my-cmp-next"
	elseif l:before ==? '' || l:before =~? '\t$'
		return "\<TAB>"
	elseif s:matchesComments(l:before, 0) || l:before =~? '\s$'
		return s:shiftwidthSpaces()
	else
		return "\<Plug>my-cmp-complete"
	endif
endfunction

function! s:matchesCommentsOrWhitespace(input) abort
	return a:input =~? '^\s\+$' || s:matchesComments(a:input, 1)
endfunction

function! s:matchesComments(input, matchToEnd) abort
	let comment = &commentstring
	if comment ==# '' | return 0 | endif
	let comment = substitute(printf(comment, ''), '\s', '', 'g')
	let match = printf('\v^\s*%s\s*', escape(comment, '*-'))
	if a:matchToEnd
		let match .= '$'
	endif
	return a:input =~? match
endfunction

function! s:shiftwidthSpaces() abort
	if &expandtab
		return "\<TAB>"
	else
		let width = &shiftwidth ? &shiftwidth : &tabstop
		let toNextTabstop = float2nr(width - fmod(virtcol('.'), width))
		return repeat(' ', toNextTabstop)
	endif
endfunction
