function! my#util#highlightGroup() abort
	let l:s = synID(line('.'), col('.'), 1)
	echo synIDattr(l:s, 'name') . ' -> ('.  synIDattr(synID(line('.'),col('.'), 0), 'name') . ') -> ' . synIDattr(synIDtrans(l:s), 'name')
endfunction

function! my#util#temp_buffer(v) abort
	execute (a:v ? 'v' : '').'new'
	setlocal buftype=nofile
	setlocal bufhidden=delete
	setlocal noswapfile
	setlocal nobuflisted
endfunction

" Quickly sets a option and resets it after updatetime
"
" The following mapping could be useful for vim files to include ':' into tag
" searches.
" nnoremap <C-]> :call my#util#oneShotSet('isk','+=',':')<CR><C-]>
function! my#util#oneShotSet(option, how, what) abort
	let reset = 'autocmd CursorHold,CursorHoldI <buffer> ++once '.
				\ 'set updatetime='.&updatetime.' | '.
				\ 'set '.a:option.'='.eval('&'.a:option)

	set updatetime=200
	augroup oneShotSet
		autocmd!
		execute reset
	augroup END
	execute 'set '.a:option.a:how.a:what
endfunction
