function my#ft#git#deleteBranch(bang, l1, l2) abort
	let line = a:l1
	let d = a:bang ? 'D' : 'd'
	while line <= a:l2
		let branch = getline(line)
		if branch[0:1] ==# '* '
			echohl Error
			echom 'Cannot delete current branch.'
			echohl Normal
		elseif branch[0:1] ==# '  '
			call system(printf('git branch -%s "%s"', d, branch[2:]))
		else
			echohl Error
			echom 'Unknown format, not deleting anything'
			echohl Normal
		endif
		let line += 1
	endwhile
	quit
	Git branch
endfunction
