if exists('g:autoloaded_map_key')
	finish
endif
let g:autoloaded_map_key = 1

function! my#map#key#enter() abort
	if s:inCompletion()
		return "\<C-y>"
	elseif s:matchesCommentsOrWhitespace(getline('.'))
		return "\<C-u>"
	elseif exists('*EndwiseDiscretionary')
		return "\<CR>\<C-r>=EndwiseDiscretionary()\<CR>"
	else
		return "\<CR>"
	endif
endfunction

function! my#map#key#tab() abort
	let l:before = strpart(getline('.'), 0, col('.') - 1)
	if vsnip#expandable()
		return "\<Plug>(vsnip-expand)"
	elseif s:inCompletion()
		return "\<C-n>"
	elseif l:before ==? '' || l:before =~? '\t$'
		return "\<TAB>"
	elseif s:matchesComments(l:before, 0) || l:before =~? '\s$'
		return s:shiftwidthSpaces()
	else
		return "\<C-x>\<C-o>"
	endif
endfunction

function! s:inCompletion() abort
	return pumvisible() || complete_info(['mode']).mode !=? ''
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
		let toNextTabstop = float2nr(&shiftwidth - fmod(virtcol('.'), &shiftwidth))
		return repeat(' ', toNextTabstop)
	endif
endfunction

