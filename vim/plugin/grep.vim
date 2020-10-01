if exists('g:loaded_grep')
	finish
endif
let g:loaded_grep = 1

let s:rgprg = 'rg --vimgrep'
let s:rgformat = '%f:%l:%c:%m,%f:%l%m,%f\ \ %l%m'

let &grepprg = s:rgprg
let &grepformat = s:rgformat

function! s:Grep(hidden, operator, rg, type, search) abort
	if !a:operator | execute a:type.'close' | endif

	let command = s:rgprg
	let command .= a:hidden ? ' --hidden' : ''
	let command .= &smartcase ? ' --smart-case' : (&ignorecase ? ' --ignore-case' : ' --case-sensitive')
	let search = escape(a:search, '%#|\')

	" Do a verbatim search in Grep
	if !a:rg
		let search = '"'.search.'"'
		let command .= ' --fixed-strings'
	endif

	let title = 'grep'. (a:hidden ? '! ' : ' ') . search

	augroup grep_highlight
		autocmd!
		execute 'autocmd QuickFixCmdPost * ++once call s:highlightMatches('.search.')'
		if !a:operator
			execute 'autocmd QuickFixCmdPost * ++once '.a:type.'window'
		endif
	augroup END

	if a:operator | echo title | endif
	let exec = { 'job': command, 'errorformat': s:rgformat, 'title': title }
	if a:type ==# 'c'
		call asyncdo#run(!a:operator, exec, search)
	else
		call asyncdo#lrun(!a:operator, exec, search)
	endif
endfunction

function! s:highlightMatches(search) abort
	let @/ = matchstr(a:search, "\\v(-)\@<!(\<)\@<=\\w+|['\"]\\zs.{-}\\ze['\"]")
	call feedkeys(":let &hlsearch=1 \| echo \<CR>", 'n')
endfunction

command! -bang -nargs=+               Grep  call s:Grep(<bang>0, 0, 0, 'c', <q-args>)
command! -bang -nargs=+               Lgrep call s:Grep(<bang>0, 0, 0, 'l', <q-args>)
command! -bang -nargs=+ -complete=dir Rg    call s:Grep(<bang>0, 0, 1, 'c', <q-args>)

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
	call s:Grep(0, 1, 0, 'c', search)
endfunction

nnoremap <silent> g/ :set operatorfunc=<SID>GrepOperator<CR>g@
xnoremap <silent> g/ :<C-u>call <SID>GrepOperator(visualmode())<CR>
