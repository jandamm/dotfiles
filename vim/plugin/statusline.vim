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
		call setwinvar(win, '&statusline', s:GetStatusLineVar(win,curwin == win))
	endfor
endfunction

" CtrlP seems to remove all autocommands when closing.
let g:ctrlp_buffer_func = { 'exit': 'CtrlPStatuslineExit' }

function! CtrlPStatuslineExit() abort
	call timer_start(0, { -> s:Setup() })
endfunction

function! s:PluginSetup() abort
	call s:Setup()
	augroup my_statusline_ft
		au!
		autocmd WinLeave <buffer> call s:Setup()
	augroup END
endfunction

augroup my_statusline
	autocmd!

	autocmd VimEnter * ++once call timer_start(0, { -> s:Setup() })

	autocmd WinEnter,BufEnter,BufDelete,SessionLoadPost,FileChangedShellPost * call s:Setup()
	autocmd FileType qf call s:Setup()

	autocmd FileType ctrlp,leaderGuide call s:PluginSetup()
augroup END
