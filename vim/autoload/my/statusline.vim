scriptencoding utf-8

if exists('g:autoloaded_statusline')
	finish
endif
let g:autoloaded_statusline = 1

hi! link User1 OneStatusLineHue2

let s:light_statusline_ft = ['qf', 'help', 'man']

function! my#statusline#get(active, winnr) abort
	let line = ''
	let bufnr = winbufnr(a:winnr)
	let filetype = getbufvar(bufnr, '&filetype')

	if index(s:light_statusline_ft, filetype) > -1
		return (a:active ? '%1*' : '') . '%<%f%*%=%P-%l-%c'
	endif

	" Left part
	let line .= a:active ? '%1*' : ''                  " Color 1
	let line .= 'ν'                                    " Symbol
	let line .= ' %<%f'                                " filename (shorten if line is too long)
	let line .= '%*'                                   " Default color
	let line .= ' (%n)'                                " Buffer number

	if a:active
		let line .= s:GitBranch()                        " Git branch
		let line .= filetype !=# '' ? ' %y' : ''         " filetype if set
		let line .= s:Spell()                            " Spelling
		let line .= s:Sleuth()                           " Show current Spaces/Tabs settings
	endif

	let line .= '%4m'                                  " modified ' [+]' (always 4 chars)
	let line .= '%5r'                                  " readonly with ' [RO]' (always 5 chars)

	" Switch sides
	let line .= '%='

	" Right part
	let line .= s:NeomakeStatusline(bufnr, a:active)   " Show Neomake Errors and Warnings
	let line .= '  %P'                                 " viewport of buffer (Top / % / Bot)
	let line .= '-%l'                                  " current line
	let line .= '-%c'                                  " current column

	return line
endfunction

function! s:Sleuth() abort
	let ret = SleuthIndicator()
	return ret !=? 'ts=2' ? ' [' . ret . ']' : ''
endfunction

function! s:Spell() abort
	return &spell ? ' [' . toupper(strcharpart(&spelllang, 0, 2)) . ']' : ''
endfunction

function! s:GitBranch() abort
	let branch = fugitive#head()
	return branch !=? '' ? ' ' . branch : ''
endfunction

function! s:NeomakeStatusline(bufnr, active) abort
	let loc = s:NeomakeListErrors('l', neomake#statusline#LoclistCounts(a:bufnr), a:active)
	if !a:active
		return loc
	endif
	let qf = s:NeomakeListErrors('c', neomake#statusline#QflistCounts(), a:active)
	let space = loc !=? '' && qf !=? '' ? ' ' : ''
	return loc . space . qf
endfunction

function! s:NeomakeListErrors(id, list, hi) abort
	if len(a:list) == 0
		return ''
	endif
	let stats = []
	for key in sort(keys(a:list))
		let hi = a:hi ? '%#NeomakeStatColorType'.key.'#' : ''
		call add(stats, hi . printf('%s=%d%%*', key, a:list[key]))
	endfor
	return a:id . '[' . join(stats, ',') . ']'
endfunction
