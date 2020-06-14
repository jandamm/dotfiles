if exists('g:loaded_grep')
	finish
endif
let g:loaded_grep = 1

set grepprg=rg\ --vimgrep
set grepformat=%f:%l:%c:%m,%f:%l%m,%f\ \ %l%m

function! s:Grep(hidden, operator, search) abort
	let buf = bufnr()
	let hidden = a:hidden ? '--hidden' : ''

	let title = ':Grep '. (a:hidden ? '!' : '') . a:search
	if a:operator | echo title | endif

	execute printf('silent grep %s "%s"', hidden, a:search)
	call setqflist([], 'a', {'title': title})
	if !a:operator
		" Reset buffer and open quickfix list
		execute 'buffer '.buf
		copen
	endif
endfunction

command! -bang -nargs=* -complete=dir Grep call s:Grep(<bang>0, 0, <q-args>)

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
	call s:Grep(0, 1, search)
endfunction

nnoremap <silent> g/ :set operatorfunc=<SID>GrepOperator<CR>g@
vnoremap <silent> g/ :<C-u>call <SID>GrepOperator(visualmode())<CR>
