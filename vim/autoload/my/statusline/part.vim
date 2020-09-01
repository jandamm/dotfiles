if exists('g:autoloaded_statusline_part')
	finish
endif
let g:autoloaded_statusline_part = 1

function! my#statusline#part#bufnr(bufnr, active) abort
	let c2 = a:active ? '%9*' : '%*'
	let c3 = a:active ? '%2*' : '%8*'
	return ' '.c2.'('.c3.'%n'.c2.')%*'
endfunction

function! my#statusline#part#git(bufnr, active) abort
	let branch = fugitive#head()
	return branch !=? '' ? ' ' . branch : ''
endfunction

function! my#statusline#part#filename(bufnr, active, prefix) abort
	return (a:active ? '%1*' : '') . a:prefix . '%<%f%*'
endfunction

function! my#statusline#part#indent(bufnr, active) abort
	let sw = &shiftwidth ? &shiftwidth : &tabstop
	if &expandtab
		let ret = 'sw='.sw
	elseif &tabstop == 2 && sw == 2
		return '' " My default setting
	elseif &tabstop == sw
		let ret = 'ts='.&tabstop
	else
		let ret = 'sw='.sw.',ts='.&tabstop
	endif
	return ' ['.ret.']'
endfunction

function! my#statusline#part#paste(bufnr, active) abort
	let c = a:active ? '%2*' : ''
	return &paste ? ' ['.c.'paste%*]' : ''
endfunction

function! my#statusline#part#qf_title(bufnr, active, prefix) abort
	let title = getwinvar(bufwinnr(a:bufnr), 'quickfix_title', '')
	return empty(title)
				\ ? ''
				\ : ' '.s:trunc(title, 100)
endfunction

function! my#statusline#part#sessions(bufnr, active) abort
	return '%{ObsessionStatus(" [$]", "")}'
endfunction

function! my#statusline#part#spell(bufnr, active) abort
	return &spell ? ' [' . toupper(strcharpart(&spelllang, 0, 2)) . ']' : ''
endfunction

function! my#statusline#part#viewport(bufnr, active) abort
	return ' %P-%l-%c'
endfunction

function! my#statusline#part#qf_count(bufnr, active) abort
	let qf = getqflist()
	let line = s:qf_part(qf, '', a:active, ' && v:val.lnum > 0')
				\ . s:qf_part(qf, 'E', a:active, '')
				\ . s:qf_part(qf, 'W', a:active, '')
				\ . s:qf_part(qf, 'I', a:active, '')

	return empty(line) ? '' : ' c['.substitute(line, ',$', '', '').']'
endfunction

function! s:qf_part(all, type, active, check) abort
	let hi = a:active ? '%#QfStatus'.a:type.'#' : ''
	let c = len(filter(copy(a:all), 'v:val.type ==? "'.a:type.'"'.a:check))
	let equals = empty(a:type) ? '' : '='
	return c > 0
				\ ? hi.a:type.equals.c.'%*,'
				\ : ''
endfunction

function! my#statusline#part#neomake(bufnr, active) abort
	if !exists('*neomake#GetJobs') | return '' | endif
	let jobs = filter(neomake#GetJobs(), 'a:bufnr == v:val.bufnr')
	let loc = s:NeomakeListErrors('l', s:NeomakeRunning(jobs, 1), neomake#statusline#LoclistCounts(a:bufnr), a:active)
	if !a:active
		return loc
	endif
	let qf = s:NeomakeListErrors('c', s:NeomakeRunning(jobs, 0), neomake#statusline#QflistCounts(), a:active)
	if empty(loc) && empty(qf)
		return ''
	endif
	let space = loc !=? '' && qf !=? '' ? ' ' : ''
	return ' ' . loc . space . qf
endfunction

" Helper {{{

" Truncate string to a length of count
function! s:trunc(string, count) abort
	let len = a:count-1
	return substitute(a:string, '\v^(.{'.len.'}).+$', '\1>', '')
endfunction

" }}}

" Neomake {{{

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
