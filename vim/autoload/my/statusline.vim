scriptencoding utf-8

if exists('g:autoloaded_statusline')
	finish
endif
let g:autoloaded_statusline = 1

hi! link User1 OneStatusLineHue2
hi! link User2 OneStatusLineMono2
hi! link User3 OneStatusLineHue62

let s:light_statusline_ft = ['qf', 'help', 'man']

function! my#statusline#overwrite(winnr, active) abort
	let filetype = getbufvar(winbufnr(a:winnr), '&filetype')
	return index(s:light_statusline_ft, filetype) > -1
endfunction

function! my#statusline#get(winnr, active) abort
	let line = a:active ? '%1*' : ''

	let bufnr = winbufnr(a:winnr)
	let filetype = getbufvar(bufnr, '&filetype')

	if index(s:light_statusline_ft, filetype) > -1
		return line . '%<%f%*%=%P-%l-%c'
	endif

	" Left part
	let line .= 'ν'                                    " Symbol
	let line .= ' %<%f'                                " filename (shorten if line is too long)
	let line .= '%*'                                   " Reset color

	let c2 = a:active ? '%2*' : '%*'
	let line .= ' '.c2.'(%3*%n'.c2.')%*'               " Buffer number

	if a:active
		let line .= s:GitBranch()                        " Git branch
		let line .= filetype !=? '' ? ' %y' : ''         " filetype if set
		let line .= s:Spell()                            " Spelling
		let line .= s:Sleuth()                           " Show current Spaces/Tabs settings
	endif

	let line .= '%4m'                                  " modified ' [+]' (always 4 chars)
	let line .= '%5r'                                  " readonly with ' [RO]' (always 5 chars)

	" Break sides
	let line .= '%='

	" Right part
	let line .= s:NeomakeStatusLine(bufnr, a:active)   " Show Neomake Errors and Warnings
	let line .= '  %P'                                 " viewport of buffer (Top / % / Bot)
	let line .= '-%l'                                  " current line
	let line .= '-%c'                                  " current column

	return line
endfunction

function! my#statusline#ctrlp(focus, byfname, regex, prev, item, next, marked) abort
	let line = '%1*'
	if a:focus ==# 'prt'
		let line .= 'ρ'
	elseif a:focus ==# 'win'
		let line .= 'ω'
	else
		let line .= a:focus
	endif
	let line .= '%*'
	let line .= ' (%3*' . (a:regex ? 'regex-' : '') . a:byfname . '%*)'
	let line .= ' [%2*'.a:prev.'%*|%1*'.a:item.'%*|%2*'.a:next.'%*]'
	let line .= a:marked ==? '<->' ? a:marked : ''
	let line .= '%=%{getcwd()}'
	return line
endfunction

function! my#statusline#ctrlp_progress(progress) abort
	return a:progress
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

function! s:NeomakeStatusLine(bufnr, active) abort
	if !exists('*neomake#GetJobs') | return '' | endif
	let jobs = s:NeomakeJobs(a:bufnr)
	let loc = s:NeomakeListErrors('l', s:NeomakeRunning(jobs, 1), neomake#statusline#LoclistCounts(a:bufnr), a:active)
	if !a:active
		return loc
	endif
	let qf = s:NeomakeListErrors('c', s:NeomakeRunning(jobs, 0), neomake#statusline#QflistCounts(), a:active)
	let space = loc !=? '' && qf !=? '' ? ' ' : ''
	return loc . space . qf
endfunction

function! s:NeomakeJobs(bufnr) abort
	return filter(neomake#GetJobs(), 'a:bufnr == v:val.bufnr')
endfunction

function! s:NeomakeRunning(jobs, loc) abort
	return !empty(filter(copy(a:jobs), 'v:val.file_mode == ' . a:loc))
endfunction

function! s:NeomakeListErrors(id, runs, errors, hi) abort
	let output = ''
	if a:runs
		let output = '...'
	elseif empty(a:errors)
		return ''
	else
		let stats = []
		let info = 0
		for key in sort(keys(a:errors))
			if key ==? 'e' || key ==? 'w'
				call add(stats, s:NeomakeFormat(a:errors[key], key, a:hi))
			else
				let info += a:errors[key] " Sum up everything that is not an Error|Warning
			endif
		endfor
		if info > 0
			call add(stats, s:NeomakeFormat(info, 'I', a:hi))
		endif
		let output = join(stats, ',')
	endif
	return printf('%s[%s]', a:id, output)
endfunction

function! s:NeomakeFormat(value, key, hi) abort
	let hi = a:hi ? '%#NeomakeStatColorType'.a:key.'#' : ''
	return hi . printf('%s=%d%%*', a:key, a:value)
endfunction
