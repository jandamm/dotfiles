command! -bang -bar -nargs=? -complete=dir Dirvish call s:DirvishOpen(<bang>0, <q-args>)

function! s:DirvishOpen(bang, ...) abort
	if a:bang
		vsplit
	endif

	call dirvish#open(a:1)
endfunction
