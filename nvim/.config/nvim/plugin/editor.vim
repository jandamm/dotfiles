augroup my_editor_group
	au!
	autocmd FocusLost * if bufname() !=? '' | update | endif

	" Dis/Enable settings for current window/buffer only
	autocmd WinEnter * call my#editor#winenter()
	autocmd WinLeave * call my#editor#winleave()

	autocmd VimResized * wincmd =

	autocmd Filetype * call timer_start(50, { -> s:fixSleuth() })

	autocmd TextYankPost * silent! lua vim.highlight.on_yank { higroup="IncSearch", timeout=500 }
augroup END

function! s:fixSleuth() abort
	if !&expandtab | call my#format#default() | endif
endfunction
