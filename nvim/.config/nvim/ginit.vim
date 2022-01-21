if has('gui_vimr')
	VimRSetFontAndSize "Jetbrains Mono", 14
	VimRSetLinespacing 1.0
endif

finish
set title
function! s:setTitlestring() abort
	let &titlestring = substitute(getcwd(), $HOME, '~', '')
endfunction
call s:setTitlestring()

augroup TitleString
	autocmd!
	autocmd DirChanged * call s:setTitlestring()
	" autocmd BufEnter * let &titlestring = bufname('.')
augroup END
