if exists('g:autoloaded_statusline')
	finish
endif
let g:autoloaded_statusline = 1

scriptencoding utf-8

function! my#statusline#colorscheme() abort
	if g:colors_name ==# 'one'
		hi! link User1 OneStatusLineHue2
		hi! link User2 OneStatusLineMono2
		hi! link User3 OneStatusLineHue62
	elseif g:colors_name ==# 'oceanic_material'
		if !exists('s:colors')
			let s:colors = g:OceanicMaterialPalette()
		endif
		call s:define_User(1, s:colors.blue, ['NONE'])
		call s:define_User(2, s:colors.grey1, ['NONE'])
		call s:define_User(3, s:colors.yellow, ['NONE'])
	elseif g:colors_name ==# 'dracula'
		call s:define_User(1, g:dracula#palette.purple, g:dracula#palette.subtle)
		call s:define_User(2, [g:dracula#palette.color_8], g:dracula#palette.subtle)
		call s:define_User(3, g:dracula#palette.yellow, g:dracula#palette.subtle)
		hi! clear Statusline
		execute 'hi! Statusline guibg='.g:dracula#palette.subtle[0]
	endif
endfunction

function! s:define_User(num, fg, bg) abort
	exec 'hi! User'.a:num.' guifg='.a:fg[0].' guibg='.a:bg[0]
endfunction

call my#statusline#colorscheme()

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

	if filetype ==# 'fugitive'
		return my#statusline#fugitive(bufnr, a:active)
	endif

	if index(s:light_statusline_ft, filetype) > -1
		return my#statusline#light(bufnr, a:active)
	endif

	return my#statusline#default(bufnr, a:active)
endfunction

function! my#statusline#default(bufnr, active) abort
	" Left part
	let line = my#statusline#part#filename(a:bufnr, a:active, 'ν ')
	let line .= my#statusline#part#bufnr(a:bufnr, a:active)

	if a:active
		let line .= my#statusline#part#git(a:bufnr, a:active)
		let line .= &filetype !=? '' ? ' %y' : '' " filetype if set
		let line .= my#statusline#part#spell(a:bufnr, a:active)
		let line .= my#statusline#part#sleuth(a:bufnr, a:active)
	endif

	let line .= '%4m' " modified ' [+]' (always 4 chars)
	let line .= '%5r' " readonly with ' [RO]' (always 5 chars)

	let line .= '%=' " Break sides

	" Right part
	let line .= my#statusline#part#neomake(a:bufnr, a:active)
	let line .= ' '.my#statusline#part#viewport(a:bufnr, a:active)

	return line
endfunction

function! my#statusline#light(bufnr, active) abort
	return my#statusline#part#filename(a:bufnr, a:active, '')
				\ .my#statusline#part#qf(a:bufnr, a:active, '')
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

	return (a:active ? '%1*' : '')
				\ .'λ '
				\ .substitute(getbufvar(a:bufnr, 'term_title'), pat, rep, '').'%*'
				\ .'%='
				\ .my#statusline#part#viewport(a:bufnr, a:active)
endfunction
