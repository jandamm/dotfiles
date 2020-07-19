if exists('g:loaded_dirvish_after')
	finish
endif
let g:loaded_dirvish_after = 1

command! -bang -bar -nargs=? -complete=dir Dirvish call s:DirvishOpen(<bang>0, <q-args>)

function! s:DirvishOpen(bang, ...) abort
	if a:bang
		vsplit
	endif

	call dirvish#open(a:1)
endfunction
