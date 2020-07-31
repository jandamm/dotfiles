if exists('g:autoloaded_statusline_part')
	finish
endif
let g:autoloaded_statusline_part = 1

function! my#statusline#part#bufnr(bufnr, active) abort
	let c2 = a:active ? '%2*' : '%*'
	return ' '.c2.'(%3*%n'.c2.')%*'
endfunction

function! my#statusline#part#git(bufnr, active) abort
	let branch = fugitive#head()
	return branch !=? '' ? ' ' . branch : ''
endfunction

function! my#statusline#part#filename(bufnr, active, prefix) abort
	return (a:active ? '%1*' : '') . a:prefix . '%<%f%*'
endfunction

function! my#statusline#part#sleuth(bufnr, active) abort
	let ret = SleuthIndicator()
	return ret !=? 'ts=2' ? ' [' . ret . ']' : ''
endfunction

function! my#statusline#part#spell(bufnr, active) abort
	return &spell ? ' [' . toupper(strcharpart(&spelllang, 0, 2)) . ']' : ''
endfunction

function! my#statusline#part#viewport(bufnr, active) abort
	return ' %P-%l-%c'
endfunction

" Neomake {{{

function! my#statusline#part#neomake(bufnr, active) abort
	if !exists('*neomake#GetJobs') | return '' | endif
	let jobs = filter(neomake#GetJobs(), 'a:bufnr == v:val.bufnr')
	let loc = s:NeomakeListErrors('l', s:NeomakeRunning(jobs, 1), neomake#statusline#LoclistCounts(a:bufnr), a:active)
	if !a:active
		return loc
	endif
	let qf = s:NeomakeListErrors('c', s:NeomakeRunning(jobs, 0), neomake#statusline#QflistCounts(), a:active)
	let space = loc !=? '' && qf !=? '' ? ' ' : ''
	return loc . space . qf
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

" }}}