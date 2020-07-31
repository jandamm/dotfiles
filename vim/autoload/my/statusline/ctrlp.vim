if exists('g:autoloaded_statusline_ctrlp')
	finish
endif
let g:autoloaded_statusline_ctrlp = 1

scriptencoding utf-8

function! my#statusline#ctrlp#main(focus, byfname, regex, prev, item, next, marked) abort
	let line = '%1*'
	if a:focus ==# 'prt'
		let line .= 'ρ'
	elseif a:focus ==# 'win'
		let line .= 'ω'
	else
		let line .= a:focus
	endif
	let line .= '%*'
	" cpsm doesn't support regex so don't show it.
	" let line .= ' (%3*' . (a:regex ? 'regex-' : '') . a:byfname . '%*)'
	let line .= ' (%3*' . a:byfname . '%*)'
	let line .= ' [%2*'.a:prev.'%*|%1*'.a:item.'%*|%2*'.a:next.'%*]'
	let line .= a:marked ==? '<->' ? a:marked : ''
	let line .= '%=%{getcwd()}'
	return line
endfunction

function! my#statusline#ctrlp#prog(progress) abort
	return a:progress
endfunction

