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
	return s:list_summary(getqflist(), a:active, 'c', winbufnr(a:winnr))
endfunction

function! my#statusline#part#loc_count(winnr, active) abort
	return s:list_summary(getloclist(a:winnr), a:active, 'l', winbufnr(a:winnr))
endfunction

function! s:list_summary(list, active, prefix, bufnr) abort
	if my#asyncdo#running(a:prefix, a:bufnr)
		let line = '...'
	else
		let line = s:qf_part(a:list, '', a:active, ' && v:val.lnum > 0')
					\ . s:qf_part(a:list, 'E', a:active, '')
					\ . s:qf_part(a:list, 'W', a:active, '')
					\ . s:qf_part(a:list, 'I', a:active, '')
	endif

	return empty(line) ? '' : ' '.a:prefix.'['.substitute(line, ',$', '', '').']'
endfunction

function! s:qf_part(all, type, active, check) abort
	let hi = a:active ? '%#QfStatus'.a:type.'#' : ''
	let c = len(filter(copy(a:all), 'v:val.type ==? "'.a:type.'"'.a:check))
	let equals = empty(a:type) ? '' : '='
	return c > 0
				\ ? hi.a:type.equals.c.'%*,'
				\ : ''
endfunction

" Helper {{{

" Truncate string to a length of count
function! s:trunc(string, count) abort
	let len = a:count-1
	return substitute(a:string, '\v^(.{'.len.'}).+$', '\1>', '')
endfunction

" }}}
