if exists('g:loaded_grep')
	finish
endif
let g:loaded_grep = 1

let s:rgprg = 'rg --vimgrep'
let s:rgformat = '%f:%l:%c:%m,%f:%l%m,%f\ \ %l%m'

let &grepprg = s:rgprg
let &grepformat = s:rgformat

function! s:Grep(hidden, operator, rg, search) abort
	if !a:operator | cclose | endif

	let command = s:rgprg
	let command .= a:hidden ? ' --hidden' : ''
	let command .= &smartcase ? ' --smart-case' : (&ignorecase ? ' --ignore-case' : ' --case-sensitive')
	let s:search = escape(a:search, '%#|\')

	" Do a verbatim search in Grep
	if !a:rg
		let s:search = '"'.s:search.'"'
		let command .= ' --fixed-strings'
	endif

	let title = 'grep'. (a:hidden ? '! ' : ' ') . s:search

	augroup grep_highlight
		autocmd!
		autocmd QuickFixCmdPost * ++once call s:highlightMatches()
		if !a:operator
			autocmd QuickFixCmdPost * ++once cwindow
		endif
	augroup END

	if a:operator | echo title | endif
	call asyncdo#run(!a:operator, { 'job': command, 'errorformat': s:rgformat, 'title': title }, s:search)
endfunction

function! s:highlightMatches() abort
	if !exists('s:search') | return | endif
	let @/ = matchstr(s:search, "\\v(-)\@<!(\<)\@<=\\w+|['\"]\\zs.{-}\\ze['\"]")
	call feedkeys(":let &hlsearch=1 \| echo \<CR>", 'n')
	unlet s:search
endfunction

command! -bang -nargs=+ Grep call s:Grep(<bang>0, 0, 0, <q-args>)
command! -bang -nargs=+ -complete=dir Rg call s:Grep(<bang>0, 0, 1, <q-args>)

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
	call s:Grep(0, 1, 0, search)
endfunction

nnoremap <silent> g/ :set operatorfunc=<SID>GrepOperator<CR>g@
xnoremap <silent> g/ :<C-u>call <SID>GrepOperator(visualmode())<CR>
