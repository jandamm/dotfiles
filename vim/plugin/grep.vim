if exists('g:loaded_grep')
	finish
endif
let g:loaded_grep = 1

let s:rgprg = 'rg --vimgrep'
let s:rgformat = '%f:%l:%c:%m,%f:%l%m,%f\ \ %l%m'

let &grepprg = s:rgprg
let &grepformat = s:rgformat

function! s:Grep(hidden, operator, verbatim, rg, search) abort
	if a:rg
		let prg = &grepprg
		let format = &grepformat

		let &grepprg = s:rgprg
		let &grepformat = s:rgformat
	endif

	if !a:operator | cclose | endif

	let buf = bufnr()
	let hidden = a:hidden ? '--hidden' : ''
	let case = &smartcase ? '--smart-case' : (&ignorecase ? '--ignore-case' : '--case-sensitive')
	let verbatim = a:verbatim ? '"' : ''
	let search = printf('%s%s%s', verbatim, escape(a:search, '%#'), verbatim)

	let title = 'grep'. (a:hidden ? '! ' : ' ') . search
	if a:operator | echo title | endif

	execute printf('silent grep %s %s %s', hidden, case, search)
	call setqflist([], 'a', {'title': title})
	if !a:operator
		" Reset buffer and open quickfix list
		execute 'buffer '.buf
		copen
	endif

	if a:rg
		let &grepprg = prg
		let &grepformat = format
	endif
endfunction

command! -bang -nargs=* Grep call s:Grep(<bang>0, 0, 1, 0, <q-args>)
command! -bang -nargs=* -complete=dir Rg call s:Grep(<bang>0, 0, 0, 1, <q-args>)

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
	call s:Grep(0, 1, 1, 0, search)
endfunction

nnoremap <silent> g/ :set operatorfunc=<SID>GrepOperator<CR>g@
vnoremap <silent> g/ :<C-u>call <SID>GrepOperator(visualmode())<CR>
