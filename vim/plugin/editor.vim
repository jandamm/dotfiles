if exists('g:loaded_editor')
	finish
endif
let g:loaded_editor = 1

augroup my_editor_group
	au!
	autocmd FocusLost * if bufname() !=? '' | update | endif

	" Dis/Enable settings for current window/buffer only
	autocmd WinEnter * call my#editor#winenter()
	autocmd WinLeave * call my#editor#winleave()

	autocmd BufReadPost * DetectIndent

	autocmd User ProsessionPre wall
augroup END

" Command to set my default tabwidth etc.
command! IndentDefault call my#format#default()

command! X !chmod +x %

" Git Messenger
let g:git_messenger_always_into_popup = v:true

" Undo Tree
let g:undotree_SetFocusWhenToggle = 1
function! g:Undotree_CustomMap() abort
	map <buffer> U <C-r>
	map <buffer> gq <CMD>UndotreeHide<CR>
endfunction

" Smalls
let g:smalls_jump_keys = 'ARSTNEIODHPLFUWY;QGJVMBKCXZ'
let g:smalls_jump_trigger = ';'
let g:smalls_auto_jump = 1
let g:smalls_auto_jump_timeout = 0.5
