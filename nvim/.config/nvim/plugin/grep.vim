if exists('g:loaded_grep')
	finish
endif
let g:loaded_grep = 1

let s:rgprg = 'rg --vimgrep'
let s:rgformat = '%f:%l:%c:%m,%f:%l%m,%f  %l%m'

let s:ackprg = 'ack -s -H --column'
let s:ackformat = '%f:%l:%c:%m,%f:%l:%m'

let &grepprg = s:rgprg
let &grepformat = s:rgformat

function! s:Grep(hidden, operator, rg, type, search) abort
	if !a:operator | execute a:type.'close' | endif

	let command = s:rgprg
	let command .= a:hidden ? ' --hidden' : ''
	let command .= &smartcase ? ' --smart-case' : (&ignorecase ? ' --ignore-case' : ' --case-sensitive')
	let search = escape(a:search, '%#|' . (a:rg ? '' : '\'))
	let match = search

	" Do a verbatim search in Grep
	if !a:rg
		let search = '"'.search.'"'
		let command .= ' --fixed-strings'
	endif

	let title = 'grep'. (a:hidden ? '! ' : ' ') . search

	augroup grep_highlight
		autocmd!
		execute 'autocmd QuickFixCmdPost * ++once call s:highlightMatches('.!a:rg.',"'.match.'")'
		call my#asyncdo#openListIf(!a:operator, a:type)
	augroup END

	if a:operator | echo title | endif
	call my#asyncdo#stop(a:type)
	call my#asyncdo#run(a:type, !a:operator, { 'job': command.' '.search, 'errorformat': s:rgformat, 'title': title })
endfunction

function! s:highlightMatches(verbatim, search) abort
	if a:verbatim
		let @/ = '\V'.a:search
	else
		let @/ = matchstr(a:search, "\\v(-)\@<!(\<)\@<=\\w+|['\"]\\zs.{-}\\ze['\"]")
	endif
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

" Temporary test for Ack
" TODO: Migrate if Ack is good
command! -bang -nargs=+ -complete=dir Ack   call s:Ack(<q-args>)
function! s:Ack(search) abort
	cclose

	let command = s:ackprg
	let command .= &smartcase ? ' --smart-case' : (&ignorecase ? ' --ignore-case' : ' --no-ignore-case')
	let search = escape(a:search, '%#|')

	" Do a verbatim search in Grep
	let title = 'ack '.search

	augroup grep_highlight
		autocmd!
		execute 'autocmd QuickFixCmdPost * ++once call s:highlightMatches(0, "'.search.'")'
		call my#asyncdo#openList('c')
	augroup END

	call my#asyncdo#stop('c')
	call my#asyncdo#run('c', 1, { 'job': command.' '.search, 'errorformat': s:ackformat, 'title': title })
endfunction
