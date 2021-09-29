if exists('g:loaded_editor')
	finish
endif
let g:loaded_editor = 1

" Use vim-sandwich with surround keybindings
runtime macros/sandwich/keymap/surround.vim

augroup my_editor_group
	au!
	autocmd FocusLost * if bufname() !=? '' | update | endif

	" Dis/Enable settings for current window/buffer only
	autocmd WinEnter * call my#editor#winenter()
	autocmd WinLeave * call my#editor#winleave()

	autocmd Filetype * call timer_start(50, { -> s:fixSleuth() })

	autocmd TextYankPost * silent! lua vim.highlight.on_yank { higroup="IncSearch", timeout=500 }
augroup END

function! s:fixSleuth() abort
	if !&expandtab | call my#format#default() | endif
endfunction

" vim-qf don't open qf automatically. (Incompatible with vim-dispatch)
let g:qf_auto_open_loclist = 0
let g:qf_auto_open_quickfix = 0
let g:qf_mapping_ack_style = 1

" Gitsigns
lua require('gitsigns').setup()

" Quick Scope
let g:qs_highlight_on_keys = ['f', 'F']

" Undo Tree
let g:undotree_SetFocusWhenToggle = 1
function! g:Undotree_CustomMap() abort
	map <buffer> U <C-r>
	map <buffer> gq <CMD>UndotreeHide<CR>
endfunction
