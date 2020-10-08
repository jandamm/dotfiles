autocmd Filetype swift call s:iOS()

function! s:iOS() abort
	let fname = expand('%:p')
	if fname =~# '.*/ios/.*\.swift'
				\ || fname =~# '.*/Projects/work/.*\.swift'
		set filetype=ios.swift
	endif
endfunction
