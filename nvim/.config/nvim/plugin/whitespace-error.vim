let s:no_tabs_fts = ['help', 'gitcommit', 'diff', 'fugitive']
" Mark trailing whitespace as error (red)
function s:MatchWhitespaceErrors()
	" https://vim.fandom.com/wiki/Highlight_long_lines
	if !exists('w:match_trail')
		let w:match_trail = matchadd('Error', '[^\t ]\zs\s\+$', -1)
	endif
	let tabs = exists('w:match_tabs')
	let no_tabs = index(s:no_tabs_fts, &filetype) >= 0
	if tabs && no_tabs
		call matchdelete(w:match_tabs)
		unlet w:match_tabs
	elseif !tabs && !no_tabs
		let w:match_tabs = matchadd('Error', '[^\t]\zs\t\+', -1)
	endif
endfunction

augroup whitespace_errors
	au!
	autocmd BufWinEnter * call s:MatchWhitespaceErrors()
augroup END
