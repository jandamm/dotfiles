if exists('g:loaded_statusline_plugin')
	finish
endif
let g:loaded_statusline_plugin = 1

" Returns the statusline string
" Here it is also decided if a non default statusline is overwritten.
function! s:GetStatusLineVar(win, active) abort
	let current = getwinvar(a:win, '&statusline')
	if current ==? ''
				\ || match(current, '\V%!my#statusline#get(\v\d+,\d+\)') >= 0
				\ || my#statusline#overwrite(a:win, a:active)
		return '%!my#statusline#get(' . a:win . ',' . a:active . ')'
	else
		return current
	endif
endfunction

function! s:Setup() abort
	let curwin = winnr()
	for win in range(1, winnr('$'))
		call setwinvar(win, '&statusline', s:GetStatusLineVar(win,!s:ctrlp && curwin == win))
	endfor
endfunction

let s:ctrlp = 0
let g:ctrlp_buffer_func = {
			\ 'enter': 'CtrlPStatuslineEnter',
			\ 'exit': 'CtrlPStatuslineExit'
			\ }

function! CtrlPStatuslineEnter() abort
	let s:ctrlp = 1
	call s:Setup()
endfunction

function! CtrlPStatuslineExit() abort
	let s:ctrlp = 0
	call timer_start(0, { -> s:Setup() })
endfunction

augroup my_statusline
	autocmd!
	autocmd WinEnter,BufEnter,BufDelete,SessionLoadPost,FileChangedShellPost * call s:Setup()
	autocmd FileType qf call s:Setup()
augroup END
