if exists('g:loaded_grep')
	finish
endif
let g:loaded_grep = 1

set grepprg=rg\ --vimgrep
set grepformat=%f:%l:%c:%m

function! s:Grep(hidden, search, operator) abort
	let buf = bufnr()
	let title = ':Grep '. (a:hidden ? '!' : '') . a:search
	if a:operator | echo title | endif
	execute 'silent grep ' . (a:hidden ? '--hidden ' : '') . a:search
	call setqflist([], 'a', {'title': title})
	if !a:operator
		" Reset buffer and open quickfix list
		execute 'buffer '.buf
		copen
	endif
endfunction

command! -bang -nargs=* -complete=dir Grep call s:Grep(<bang>0,<f-args>,0)

function! s:GrepOperator(type) abort
	let reg_g = @g
	if a:type ==# 'v'
		normal! `<v`>"gy
	elseif a:type ==# 'char'
		normal! `[v`]"gy
	else
		return
	endif
	let search = @g
	let @g = reg_g
	call s:Grep(0,search,1)
endfunction

nnoremap <silent> g/ :set operatorfunc=<SID>GrepOperator<CR>g@
vnoremap <silent> g/ :<C-u>call <SID>GrepOperator(visualmode())<CR>
