if exists('g:autoloaded_my_grep')
	finish
endif
let g:autoloaded_my_grep = 1

let s:rgprg = 'rg --vimgrep'
let s:rgformat = '%f:%l:%c:%m,%f:%l%m,%f  %l%m'

let s:ackprg = 'ack -s -H --column'
let s:ackformat = '%f:%l:%c:%m,%f:%l:%m'

" Mode: 0 -> ack; 1 -> verbatim search; 2 -> rg
function! my#grep#command(bang, operator, mode, scope, search) abort
	let ack = a:mode == 0
	let verbatim = a:mode == 1

	let command = s:getCommand(a:bang, ack)
	let format = ack ? s:ackformat : s:rgformat

	let search = escape(a:search, '%#|' . (verbatim ? '\' : ''))
	let match = search

	if verbatim
		let search = '"'.search.'"'
		let command .= ack ? ' --literal' : ' --fixed-strings'
	endif

	let title = (ack ? 'Ack': 'Grep') . (a:bang ? '! ' : ' ') . search

	augroup grep_highlight
		autocmd!
		execute 'autocmd QuickFixCmdPost * ++once call s:highlightMatches('.verbatim.',"'.match.'")'
		call my#asyncdo#openListIf(!a:operator, a:scope)
	augroup END

	if !a:operator | execute a:scope.'close' | endif

	call my#asyncdo#stop(a:scope)
	call my#asyncdo#run(a:scope, 0, !a:operator, { 'job': command, 'errorformat': format, 'title': title }, search)
endfunction

function! s:getCommand(bang, ack) abort
	return (a:ack ? s:ackprg : s:rgprg) . s:getBang(a:bang, a:ack) . s:getCasing(a:ack)
endfunction

function! s:getBang(bang, ack) abort
	return a:bang ? ' --'.(a:ack ? 'noenv' : 'hidden') : ''
endfunction

function! s:getCasing(ack) abort
	if &smartcase && &ignorecase
		return ' --smart-case'
	elseif &ignorecase
		return ' --ignore-case'
	elseif a:ack
		return ' --no-ignore-case'
	else
		return ' --case-sensitive'
	endif
endfunction

function! s:highlightMatches(verbatim, search) abort
	if a:verbatim
		let @/ = '\V'.a:search
	else
		let @/ = matchstr(a:search, "\\v(-)\@<!(\<)\@<=\\w+|['\"]\\zs.{-}\\ze['\"]")
	endif
	call feedkeys(":let &hlsearch=1 \| echo \<CR>", 'n')
endfunction

function! my#grep#operator(type) abort
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
	call my#grep#command(0, 1, 1, 'c', search)
endfunction

