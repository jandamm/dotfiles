if exists('g:autoloaded_statusline')
	finish
endif
let g:autoloaded_statusline = 1

scriptencoding utf-8

let s:light_statusline_ft = ['qf', 'help', 'man']

function! my#statusline#overwrite(winnr, active) abort
	let filetype = getbufvar(winbufnr(a:winnr), '&filetype')
	return index(s:light_statusline_ft, filetype) > -1
endfunction

function! my#statusline#get(winnr, active) abort
	let bufnr = winbufnr(a:winnr)
	let filetype = getbufvar(bufnr, '&filetype')

	if filetype ==# 'terminal'
		return my#statusline#terminal(bufnr, a:active)
	endif

	if filetype ==# 'dirvish'
		return my#statusline#dirvish(bufnr, a:active)
	endif

	if filetype ==# 'fugitive' || bufname(bufnr) =~# '^fugitive://'
		return my#statusline#fugitive(bufnr, a:active)
	endif

	if index(s:light_statusline_ft, filetype) > -1
		return my#statusline#light(bufnr, a:active)
	endif

	return my#statusline#default(bufnr, a:active)
endfunction

function! my#statusline#default(bufnr, active) abort
	" Left part
	let line  = my#statusline#part#filename(a:bufnr, a:active, 'ν ')
	let line .= my#statusline#part#bufnr(a:bufnr, a:active)

	if a:active
		let line .= my#statusline#part#git(a:bufnr, a:active)
		let line .= my#statusline#part#sessions(a:bufnr, a:active)
		let line .= my#statusline#part#paste(a:bufnr, a:active)
		let line .= &filetype !=? '' ? ' %y' : '' " filetype if set
		let line .= my#statusline#part#spell(a:bufnr, a:active)
		let line .= my#statusline#part#indent(a:bufnr, a:active)
	endif

	let line .= '%4m' " modified ' [+]' (always 4 chars)
	let line .= '%5r' " readonly with ' [RO]' (always 5 chars)

	let line .= '%=' " Break sides

	" Right part
	if a:active
		let line .= my#statusline#part#qf_count(a:bufnr, a:active)
	endif
	let line .= my#statusline#part#neomake(a:bufnr, a:active)
	let line .= ' '.my#statusline#part#viewport(a:bufnr, a:active)

	return line
endfunction

function! my#statusline#light(bufnr, active) abort
	return my#statusline#part#filename(a:bufnr, a:active, '', 1)
				\ .my#statusline#part#qf_title(a:bufnr, a:active, '')
				\ .'%='
				\ .my#statusline#part#viewport(a:bufnr, a:active)
endfunction

function! my#statusline#dirvish(bufnr, active) abort
	return my#statusline#part#filename(a:bufnr, a:active, 'ν ')
				\ .my#statusline#part#bufnr(a:bufnr, a:active)
				\ .my#statusline#part#git(a:bufnr, a:active)
				\ .'%='
				\ .my#statusline#part#viewport(a:bufnr, a:active)
endfunction

function! my#statusline#fugitive(bufnr, active) abort
	return my#statusline#part#filename(a:bufnr, a:active, 'δ ')
				\ .my#statusline#part#bufnr(a:bufnr, a:active)
				\ .my#statusline#part#git(a:bufnr, a:active)
				\ .'%='
				\ .my#statusline#part#viewport(a:bufnr, a:active)
endfunction

function! my#statusline#terminal(bufnr, active) abort
	" get dir, pid and bin.
	let pat = '\vterm:\/\/(.*)\/\/(\d*):%(\/usr\/%(local\/)?bin\/)?(.*)'
	" set dir, bufnr, bin, pid
	let rep = '\1%*'.my#statusline#part#bufnr(a:bufnr, a:active).' [\3] [\2]'
	let term_title = substitute(getbufvar(a:bufnr, 'term_title'), pat, rep, '')
	let is_gsh = match(term_title, '^[^\[]*\[gsh\]') == 0

	return (a:active ? '%1*' : '')
				\ .(is_gsh ? 'δ ' : 'λ ')
				\ .term_title.'%*'
				\ .'%='
				\ .my#statusline#part#viewport(a:bufnr, a:active)
endfunction
