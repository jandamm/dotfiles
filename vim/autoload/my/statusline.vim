scriptencoding utf-8

if exists('g:autoloaded_statusline')
	finish
endif
let g:autoloaded_statusline = 1

function! my#statusline#get(active, winnr) abort
	let filetype = getbufvar(winbufnr(a:winnr), '&filetype')
	if filetype ==? 'qf'
		return '%1*%<%f%*%=%P-%l-%c'
	endif
	let line = ''                                      " Define
	if a:active
		let line .= '%1*'                                " Color 1
	endif
	let line .= 'ν'                                    " Symbol
	let line .= ' %<%f'                                " filename (shorten if line is too long)
	let line .= '%*'                                   " Default color
	let line .= ' (%n)'                                " Buffer number
	let line .= s:GitBranch()                          " Git branch
	if filetype !=# ''
		let line .= ' %y'                                " filetype with [ft]
	endif
	if a:active
		let line .= s:Spell()                            " Spelling
		let line .= s:MySleuth()                         " Show current Spaces/Tabs settings (Maybe only if not ts=2)
	endif
	let line .= '%4m'                                  " modified ' [+]' (always 4 chars)
	let line .= '%5r'                                  " readonly with ' [RO]' (always 5 chars)
	let line .= '%='                                   " right align from here
	if a:active
		let line .= s:NeomakeStatusline()                " Quick hack for Neomake Errors/Warnings
	endif
	let line .= '  %P'                                 " viewport of buffer (Top / % / Bot)
	let line .= '-%l'                                  " current line
	let line .= '-%c'                                  " current column
	return line
endfunction

function! s:MySleuth() abort
	let ret = SleuthIndicator()
	return ret ==? 'ts=2' ? '' : ' [' . ret . ']'
endfunction

function! s:Spell() abort
	return &spell ? ' [' . toupper(strcharpart(&spelllang, 0, 2)) . ']' : ''
endfunction

function! s:GitBranch() abort
	let branch = fugitive#head()
	return len(branch) > 0 ? ' ' . branch : ''
endfunction

function! s:NeomakeStatusline() abort
	" return neomake#statusline#get(a:bufnr, {
	" \ 'format_running': 'l[… ({{running_job_names}})]',
	" \ 'format_loclist_ok': '',
	" 				\ 'format_loclist_issues': 'l[%s%%*]',
	" \ 'format_quickfix_ok': '',
	" \ 'format_quickfix_issues': (a:active ? 'c[%s%%*]' : '')
	" \ })
	" TODO: Reformat: l[E=1,W=2] c[W=3]
	let stats = []
	let lcounts = neomake#statusline#LoclistCounts()
	if len(lcounts) > 0
		call add(stats, 'l[')
		for key in sort(keys(lcounts))
			call add(stats, printf('%%#NeomakeStatColorType%s#%s=%d%%*', key, key, lcounts[key]))
		endfor
		call add(stats, ']')
	endif
	let qcounts = neomake#statusline#QflistCounts()
	if len(qcounts) > 0
		call add(stats, 'c[')
		for key in sort(keys(qcounts))
			call add(stats, printf('%%#NeomakeStatColorType%s#%s:%d%%*', key, key, qcounts[key]))
		endfor
		call add(stats, ']')
	endif
	return join(stats, ' ')
endfunction
