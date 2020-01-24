" Mark trailing whitespace as error (red)
function MatchWhitespaceErrors()
	" https://vim.fandom.com/wiki/Highlight_long_lines
	if !exists('w:no_whitespace_error')
		let w:w1=matchadd('ErrorMsg', '\s\+$', -1)
		let w:w2=matchadd('ErrorMsg', '[^\t]\zs\t\+', -1)
	endif
endfunction

" Execute initially (first window)
autocmd VimEnter * call MatchWhitespaceErrors()

" Exectue for every new window
" https://vim.fandom.com/wiki/Detect_window_creation_with_WinEnter
augroup whitespace_errors
	au!
	autocmd VimEnter * autocmd whitespace_errors WinEnter * let w:created=1
	autocmd WinEnter * if !exists('w:created') | call MatchWhitespaceErrors() | endif
augroup END
