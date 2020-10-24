if exists('g:autoloaded_statusline_part')
	finish
endif
let g:autoloaded_statusline_part = 1

function! my#statusline#part#bufnr(winnr, active) abort
	let c2 = a:active ? '%9*' : '%*'
	let c3 = a:active ? '%2*' : '%8*'
	return ' '.c2.'('.c3.'%n'.c2.')%*'
endfunction

function! my#statusline#part#case_sensitivity(winnr, active) abort
	if &smartcase && &ignorecase
		return '' " Smartcase is default
	elseif !&smartcase && &ignorecase
		return ' [ic]'
	else
		return ' [noic]'
	endif
endfunction

function! my#statusline#part#git(winnr, active) abort
	let branch = fugitive#head()
	return branch !=? '' ? ' ' . branch : ''
endfunction

function! my#statusline#part#filename(winnr, active, prefix, ...) abort
	" Light mode
	if a:0 && a:1
		let path = ''
		let file = '%f'
	else
		let full = fnamemodify(bufname(winbufnr(a:winnr)), ':~:.')
		let file = fnamemodify(full, ':t')
		let path = fnamemodify(full, ':h')
		if path ==# '.' && !empty(file)
			" files in pwd show just filenames
			let path = ''
		elseif path !=# '.' && path !=# '~' || !empty(file)
			" Don't append `/` to folders pwd and HOME
			let path .= '/'
		endif
	endif
	return printf(a:active
				\ ? '%%1*%s%%3*%%<%s%%1*%s%%*'
				\ : '%s%%<%s%%8*%s%%*',
				\ a:prefix, path, file)
endfunction

function! my#statusline#part#indent(winnr, active) abort
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

function! my#statusline#part#paste(winnr, active) abort
	let c = a:active ? '%2*' : ''
	return &paste ? ' ['.c.'paste%*]' : ''
endfunction

function! my#statusline#part#qf_title(winnr, active, prefix) abort
	let title = getwinvar(a:winnr, 'quickfix_title', '')
	return empty(title)
				\ ? ''
				\ : ' '.s:trunc(title, 100)
endfunction

function! my#statusline#part#sessions(winnr, active) abort
	return '%{ObsessionStatus(" [$]", "")}'
endfunction

function! my#statusline#part#spell(winnr, active) abort
	return &spell ? ' [' . toupper(strcharpart(&spelllang, 0, 2)) . ']' : ''
endfunction

function! my#statusline#part#viewport(winnr, active) abort
	return ' %P-%l-%c'
endfunction

function! my#statusline#part#qf_count(winnr, active) abort
	return s:qf_summary('c', a:winnr, a:active)
endfunction

function! my#statusline#part#loc_count(winnr, active) abort
	return s:qf_summary('l', a:winnr, a:active)
endfunction

if !exists('s:qf_cache') | let s:qf_cache = {} | endif

function! s:qf_cached(prefix, winnr) abort
	" Should I use winid? Leads to less recomputation but increases cache since
	" every new window gets its own entry.
	let key = a:prefix ==# 'c' ? 'qf' : win_getid(a:winnr)
	let id = s:get_list(key, 'id')
	if has_key(s:qf_cache, key) && s:qf_cache[key]['id'] == id
		return s:qf_cache[key]
	endif

	let entry = { '': 0, 'E': 0, 'W': 0, 'I': 0, 'id': id }
	let s:qf_cache[key] = entry
	let items = s:get_list(key, 'items')

	for item in items
		if item.type ==? 'E'
			let entry.E += 1
		elseif item.type ==? 'W'
			let entry.W += 1
		elseif item.type ==? 'I'
			let entry.I += 1
		elseif item.type ==? '' && item.lnum > 0
			let entry[''] += 1
		endif
	endfor
	return entry
endfunction

function! s:get_list(list, value) abort
	let list = a:list ==# 'qf' ? getqflist({ a:value : 0 }) : getloclist(a:list, { a:value : 0 })
	return list[a:value]
endfunction

function! s:qf_summary(prefix, winnr, active) abort
	let format = ' '.a:prefix.'[%s]'
	if my#asyncdo#running(a:prefix, a:winnr)
		return printf(format, '...')
	else
		let data = s:qf_cached(a:prefix, a:winnr)
		let line = s:qf_part(data, '', a:active)
					\ . s:qf_part(data, 'E', a:active)
					\ . s:qf_part(data, 'W', a:active)
					\ . s:qf_part(data, 'I', a:active)
	endif

	return empty(line) ? '' : printf(format, substitute(line, ',$', '', ''))
endfunction

function! s:qf_part(data, type, active) abort
	let c = a:data[a:type]
	if c == 0 | return '' | endif
	let hi = a:active ? '%#QfStatus'.a:type.'#' : ''
	let equals = empty(a:type) ? '' : '='
	return hi.a:type.equals.c.'%*,'
endfunction

" Helper {{{

" Truncate string to a length of count
function! s:trunc(string, count) abort
	let len = a:count-1
	return substitute(a:string, '\v^(.{'.len.'}).+$', '\1>', '')
endfunction

" }}}
