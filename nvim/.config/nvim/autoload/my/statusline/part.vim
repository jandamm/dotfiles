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
	return luaeval("require('my.statusline').git {bufnr =".winbufnr(a:winnr).'}')
endfunction

function! my#statusline#part#filename_light(winnr, active) abort
	return a:active ? '%1*%f%*' : '%f'
endfunction

function! my#statusline#part#filename(winnr, active, prefix) abort
	let full = fnamemodify(bufname(winbufnr(a:winnr)), ':~:.')
	let file = fnamemodify(full, ':t')
	let ext = fnamemodify(full, ':e')
	let path = fnamemodify(full, ':h')
	if path ==# '.' && !empty(file)
		" files in pwd show just filenames
		let path = ''
	elseif path !=# '.' && path !=# '~' || !empty(file)
		" Don't append `/` to folders pwd and HOME
		let path .= '/'
	endif
	let icon = luaeval("require'nvim-web-devicons'.get_icon(_A[1], _A[2]) or _A[3]", [file, ext, a:prefix])
	if !empty(icon) | let icon .= ' ' | endif
	return printf(a:active
				\ ? '%%1*%s%%3*%%<%s%%1*%s%%*'
				\ : '%s%%<%s%%8*%s%%*',
				\ icon, path, file)
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
	return &paste ? ' ['.c.'system%*]' : ''
endfunction

function! my#statusline#part#qf_title(winnr, active) abort
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

function! my#statusline#part#diagnostics(winnr, active) abort
	let bufnr = winbufnr(a:winnr)
	let line = s:diag_part('Error', bufnr, a:active)
				\. s:diag_part('Warning', bufnr, a:active)
				\. s:diag_part('Information', bufnr, a:active)
				\. s:diag_part('Hint', bufnr, a:active)

	return empty(line) ? '' : ' ' . substitute(line, ',', ' ', 'g')
endfunction

function! my#statusline#part#qf_loc_count(winnr, active) abort
	let type = getbufvar(winbufnr(a:winnr), 'qf_isLoc') ? 'l' : 'c'
	return s:qf_summary(type, a:winnr, a:active, '')
endfunction

function! my#statusline#part#qf_count(winnr, active) abort
	return s:qf_summary('c', a:winnr, a:active)
endfunction

function! my#statusline#part#loc_count(winnr, active) abort
	if s:get_list(win_getid(a:winnr), 'title') ==? 'Language Server'
		return ''
	endif
	return s:qf_summary('l', a:winnr, a:active)
endfunction

if !exists('s:qf_cache') | let s:qf_cache = {} | endif

function! s:qf_cached(prefix, winnr) abort
	let key = a:prefix ==# 'c' ? 'qf' : win_getid(a:winnr)
	let id = s:get_list(key, 'id')
	let tick = s:get_list(key, 'changedtick')
	if has_key(s:qf_cache, key) && s:qf_cache[key].id == id && s:qf_cache[key].tick == tick
		return s:qf_cache[key]
	endif

	let entry = { '': 0, 'E': 0, 'W': 0, 'I': 0, 'id': id, 'tick': tick }
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

function! s:qf_summary(type, winnr, active, ...) abort
	let prefix = a:0 ? a:1 : a:type
	let format = ' '.prefix.'[%s]'
	let data = s:qf_cached(a:type, a:winnr)
	let line = s:qf_part(data, '', a:active)
				\ . s:qf_part(data, 'E', a:active)
				\ . s:qf_part(data, 'W', a:active)
				\ . s:qf_part(data, 'I', a:active)

	return empty(line) ? '' : printf(format, substitute(line, ',$', '', ''))
endfunction

function! s:qf_part(data, type, active) abort
	let c = a:data[a:type]
	return s:dqf_part(c, a:type, a:active)
endfunction

function! s:diag_part(type, bufnr, active) abort
	let c = luaeval('vim.lsp.diagnostic.get_count('.a:bufnr.', "'.a:type.'")')
	return s:dqf_part(c, strpart(a:type, 0, 1), a:active)
endfunction

let s:Symbols = luaeval('require("my.symbols")')
function! s:dqf_part(count, type, active) abort
	if a:count == 0 | return '' | endif
	let hi = a:active ? '%#LspDiagnosticsStatus'.a:type.'#' : ''
	let type = get(s:Symbols, a:type, '')
	let sep = empty(type) ? '' : ' '
	return hi.type.sep.a:count.'%*,'
endfunction

" Helper {{{

" Truncate string to a length of count
function! s:trunc(string, count) abort
	let len = a:count-1
	return substitute(a:string, '\v^(.{'.len.'}).+$', '\1>', '')
endfunction

" }}}
