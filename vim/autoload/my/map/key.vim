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
	if vsnip#expandable()
		return "\<Plug>(vsnip-expand)"
	elseif pumvisible()
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

