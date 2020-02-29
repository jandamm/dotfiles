" Mark trailing whitespace as error (red)
function s:MatchWhitespaceErrors()
	" https://vim.fandom.com/wiki/Highlight_long_lines
	if !exists('w:no_whitespace_error')
		if !exists('w:no_whitespace_error_trail')
			let w:w1=matchadd('Error', '\s\+$', -1)
		endif
		if !exists('w:no_whitespace_error_tabs')
			let w:w2=matchadd('Error', '[^\t]\zs\t\+', -1)
		endif
	endif
endfunction

" https://vim.fandom.com/wiki/Detect_window_creation_with_WinEnter
augroup whitespace_errors
	au!
	autocmd VimEnter * autocmd whitespace_errors WinEnter * let w:created=1
	autocmd VimEnter,WinEnter * if !exists('w:created') | call s:MatchWhitespaceErrors() | endif
augroup END
