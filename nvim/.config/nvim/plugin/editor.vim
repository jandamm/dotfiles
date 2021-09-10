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

	" Signify FocusGained isn't working for some reason. (Disables signs)
	" With a delay it seems to work just fine.
	autocmd User SignifyAutocmds autocmd! signify FocusGained
	autocmd FocusGained * call timer_start(0, {-> execute('SignifyRefresh') })

	autocmd BufReadPost,BufNewFile * DetectIndent

	autocmd TextYankPost * silent! lua vim.highlight.on_yank { higroup="IncSearch", timeout=500 }
	autocmd User ProsessionPre wall
augroup END

" Git Messenger
let g:git_messenger_always_into_popup = v:true

" Quick Scope
let g:qs_highlight_on_keys = ['f', 'F']

" Undo Tree
let g:undotree_SetFocusWhenToggle = 1
function! g:Undotree_CustomMap() abort
	map <buffer> U <C-r>
	map <buffer> gq <CMD>UndotreeHide<CR>
endfunction
