if exists('g:autoloaded_map_key')
	finish
endif
let g:autoloaded_map_key = 1

function! my#map#key#enter() abort
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

function! my#map#key#tab() abort
	let l:before = strpart(getline('.'), 0, col('.') - 1)
	if vsnip#expandable()
		return "\<Plug>(vsnip-expand)"
	elseif pumvisible()
		return "\<C-n>"
	elseif l:before ==? '' || l:before =~? '\t$'
		return "\<TAB>"
	elseif s:matchesComments(l:before, 0) || l:before =~? '\s$'
		return s:shiftwidthSpaces()
	else
		return "\<C-x>\<C-o>"
	endif
endfunction

function! s:matchesCommentsOrWhitespace(input) abort
	return a:input =~? '^\s\+$' || s:matchesComments(a:input, 1)
endfunction

function! s:matchesComments(input, matchToEnd) abort
	let l:match = '\v^\s*(//|#|")\s*'
	if a:matchToEnd
		let l:match .= '$'
	endif
	return a:input =~? l:match
endfunction

function! s:shiftwidthSpaces() abort
	if &expandtab
		return "\<TAB>"
	else
		let toNextTabstop = float2nr(&shiftwidth - fmod(virtcol('.'), &shiftwidth))
		return repeat(' ', toNextTabstop)
	endif
endfunction

