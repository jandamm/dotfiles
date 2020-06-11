if exists('g:loaded_editor')
	finish
endif
let g:loaded_editor = 1

augroup auto_save_files
	au!
	autocmd FocusLost * if bufname() !=? '' | update | endif " Test
augroup END

" Command to set my default tabwidth etc.
command! SleuthOverwrite call my#format#default()

command! X !chmod +x %

" Undo Tree
let g:undotree_SetFocusWhenToggle = 1
function g:Undotree_CustomMap() abort
	map <buffer> U <C-r>
endfunction
