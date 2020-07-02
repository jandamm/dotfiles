if exists('g:loaded_grep')
	finish
endif
let g:loaded_grep = 1

set grepprg=rg\ --vimgrep
set grepformat=%f:%l:%c:%m,%f:%l%m,%f\ \ %l%m

function! s:Grep(hidden, operator, quote, search) abort
	if !a:operator | cclose | endif

	let buf = bufnr()
	let hidden = a:hidden ? '--hidden' : ''
	let case = &smartcase ? '--smart-case' : (&ignorecase ? '--ignore-case' : '--case-sensitive')
	let quote = a:quote ? '"' : ''
	let search = printf('%s%s%s', quote, a:search, quote)

	let title = 'grep'. (a:hidden ? '! ' : ' ') . search
	if a:operator | echo title | endif

	execute printf('silent grep %s %s %s', hidden, case, search)
	call setqflist([], 'a', {'title': title})
	if !a:operator
		" Reset buffer and open quickfix list
		execute 'buffer '.buf
		copen
	endif
endfunction

command! -bang -nargs=* Grep call s:Grep(<bang>0, 0, 1, <q-args>)
command! -bang -nargs=* -complete=dir Rg call s:Grep(<bang>0, 0, 0, <q-args>)

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
	call s:Grep(0, 1, 1, search)
endfunction

nnoremap <silent> g/ :set operatorfunc=<SID>GrepOperator<CR>g@
vnoremap <silent> g/ :<C-u>call <SID>GrepOperator(visualmode())<CR>
