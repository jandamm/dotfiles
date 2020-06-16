if exists('g:loaded_editor')
	finish
endif
let g:loaded_editor = 1

augroup my_editor_group
	au!
	autocmd FocusLost * if bufname() !=? '' | update | endif " Test
	autocmd WinEnter * if winnr('$') == 1 && &buftype == "quickfix" | q | endif
augroup END

" Command to set my default tabwidth etc.
command! SleuthOverwrite call my#format#default()

command! X !chmod +x %

" Undo Tree
let g:undotree_SetFocusWhenToggle = 1
function g:Undotree_CustomMap() abort
	map <buffer> U <C-r>
endfunction
