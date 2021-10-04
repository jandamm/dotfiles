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
	let line .= ' (%2*' . (a:regex ? 'regex-' : '') . a:byfname . '%*)'
	let line .= ' [%9*'.a:prev.'%*|%1*'.a:item.'%*|%9*'.a:next.'%*]'
	let line .= a:marked ==? '<->' ? a:marked : ''
	let line .= '%=%{getcwd()}'
	return line
endfunction

function! my#statusline#ctrlp#prog(progress) abort
	return a:progress
endfunction
