if exists('g:loaded_filetype_after')
	finish
endif
let g:loaded_filetype_after = 1

augroup ios_detection
	au!
	autocmd BufReadPost */Projects/work/*.swift call timer_start(0, { -> s:iOS() })
	autocmd BufReadPost */ios/*.swift call timer_start(0, { -> s:iOS() })
augroup END

function! s:iOS() abort
	set filetype=ios.swift
endfunction
