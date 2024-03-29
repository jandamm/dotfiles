scriptencoding utf-8

function! my#statusline#default(winnr, active) abort
	" Left part
	let line  = my#statusline#part#filename(a:winnr, a:active, 'Ϟ')
	let line .= my#statusline#part#bufnr(a:winnr, a:active)

	if a:active
		let line .= my#statusline#part#git(a:winnr, a:active)
		let line .= my#statusline#part#sessions(a:winnr, a:active)
		let line .= my#statusline#part#paste(a:winnr, a:active)
		let line .= &filetype !=? '' ? ' %y' : '' " filetype if set
		let line .= my#statusline#part#spell(a:winnr, a:active)
		let line .= my#statusline#part#indent(a:winnr, a:active)
		let line .= my#statusline#part#case_sensitivity(a:winnr, a:active)
	endif

	let line .= '%4m' " modified ' [+]' (always 4 chars)
	let line .= '%5r' " readonly with ' [RO]' (always 5 chars)

	let line .= '%=' " Break sides

	" Right part
	let line .= my#statusline#part#diagnostics(a:winnr, a:active)
	if a:active
		let line .= my#statusline#part#qf_count(a:winnr, a:active)
	endif
	let line .= my#statusline#part#loc_count(a:winnr, a:active)
	let line .= ' '.my#statusline#part#viewport(a:winnr, a:active)

	return line
endfunction

function! my#statusline#light(winnr, active) abort
	return my#statusline#part#filename_light(a:winnr, a:active)
				\ .'%='
				\ .my#statusline#part#viewport(a:winnr, a:active)
endfunction

function! my#statusline#qf(winnr, active) abort
	return my#statusline#part#filename_light(a:winnr, a:active)
				\ .my#statusline#part#qf_title(a:winnr, a:active)
				\ .'%='
				\ .my#statusline#part#qf_loc_count(a:winnr, a:active)
				\ .' '.my#statusline#part#viewport(a:winnr, a:active)
endfunction

function! my#statusline#dirvish(winnr, active) abort
	return my#statusline#part#filename(a:winnr, a:active, 'Ϟ')
				\ .my#statusline#part#bufnr(a:winnr, a:active)
				\ .my#statusline#part#git(a:winnr, a:active)
				\ .'%='
				\ .my#statusline#part#viewport(a:winnr, a:active)
endfunction

function! my#statusline#fugitive(winnr, active) abort
	return my#statusline#part#filename(a:winnr, a:active, '')
				\ .my#statusline#part#bufnr(a:winnr, a:active)
				\ .my#statusline#part#git(a:winnr, a:active)
				\ .'%='
				\ .my#statusline#part#viewport(a:winnr, a:active)
endfunction

function! my#statusline#terminal(winnr, active) abort
	" get dir, pid and bin.
	let pat = '\vterm:\/\/(.*)\/\/(\d*):%(\/usr\/%(local\/)?bin\/)?(.*)'
	" set dir, bufnr, bin, pid
	let rep = '\1%*'.my#statusline#part#bufnr(a:winnr, a:active).' [\3] [\2]'
	let term_title = substitute(getbufvar(winbufnr(a:winnr), 'term_title'), pat, rep, '')
	let is_gsh = match(term_title, '^[^\[]*\[gsh\]') == 0

	return (a:active ? '%1*' : '')
				\ .(is_gsh ? ' ' : 'λ ')
				\ .term_title.'%*'
				\ .(a:active ? my#statusline#part#paste(a:winnr, a:active) : '')
				\ .'%='
				\ .my#statusline#part#viewport(a:winnr, a:active)
endfunction
