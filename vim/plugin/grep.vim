if exists('g:loaded_grep')
	finish
endif
let g:loaded_grep = 1

set grepprg=rg\ --vimgrep
set grepformat=%f:%l:%c:%m

function! s:Grep(type) abort
	let reg_g = @g
	if a:type ==# 'v'
		normal! `<v`>"gy
	elseif a:type ==# 'char'
		normal! `[v`]"gy
	else
		return
	endif
	let search = 'Grep ' . @g
	let @g = reg_g
	echo ':'.search
	execute search
	call setqflist([], 'a', {'title': search})
endfunction

command! -nargs=* -complete=dir Grep silent grep <f-args>

nnoremap <silent> g/ :set operatorfunc=<SID>Grep<CR>g@
vnoremap <silent> g/ :<C-u>call <SID>Grep(visualmode())<CR>
