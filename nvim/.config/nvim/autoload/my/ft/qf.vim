if exists('g:autoloaded_ft_qf')
	finish
endif
let g:autoloaded_ft_qf = 1

function! my#ft#qf#removeEntry(...) abort
	let cursor = getcurpos()
	let idx = cursor[1] - 1
	if exists('b:qf_isLoc') && b:qf_isLoc
		let nr = winnr()
		let title = getloclist(nr, { 'title': 1 })
		let qf = getloclist(nr)
		call remove(qf, idx)
		call setloclist(nr, qf)
		call setloclist(nr, [], 'a', title)
	else
		let title = getqflist({ 'title': 1 })
		let qf = getqflist()
		call remove(qf, idx)
		call setqflist(qf)
		call setqflist([], 'a', title)
	endif
	call setpos('.', cursor)
endfunction
