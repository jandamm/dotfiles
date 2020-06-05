if exists('g:loaded_statusline_plugin')
	finish
endif
let g:loaded_statusline_plugin = 1

function! s:Setup() abort
	let window = winnr()
	for i in range(1, winnr('$'))
		let active = window == i
		call setwinvar(i, '&statusline', '%!my#statusline#get('. active .','.i.')')
	endfor
endfunction

augroup my_statusline
	autocmd!
	autocmd WinEnter,BufEnter,BufDelete,SessionLoadPost,FileChangedShellPost * call s:Setup()
	autocmd FileType qf call s:Setup()
augroup END
