if exists('g:loaded_statusline_plugin')
	finish
endif
let g:loaded_statusline_plugin = 1

" Returns the statusline string
" Here it is also decided if a non default statusline is overwritten.
" (E.g. setting a specific statusline for ft=qf which has a local set.
function! s:GetStatusLineVar(win, active) abort
	let current = getwinvar(a:win, '&statusline')
	if current ==? '' || match(current, '\V%!my#statusline#get(\v\d+,\d+\)') >= 0
		return '%!my#statusline#get(' . a:active . ',' . a:win . ')'
	else
		return current
	endif
endfunction

function! s:Setup() abort
	let curwin = winnr()
	for win in range(1, winnr('$'))
		call setwinvar(win, '&statusline', s:GetStatusLineVar(win,curwin == win))
	endfor
endfunction

augroup my_statusline
	autocmd!
	autocmd WinEnter,BufEnter,BufDelete,SessionLoadPost,FileChangedShellPost * call s:Setup()
	autocmd FileType qf call s:Setup()
augroup END
