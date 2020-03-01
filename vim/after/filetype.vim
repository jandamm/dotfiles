if exists('g:loaded_filetype_after')
	finish
endif
let g:loaded_filetype_after = 1

augroup ios_detection
	au!
	autocmd BufRead */Projects/work/*.swift set filetype=ios.swift
	autocmd BufRead */ios/*.swift set filetype=ios.swift
augroup END
