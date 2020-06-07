if exists('g:loaded_grep')
	finish
endif
let g:loaded_grep = 1

set grepprg=rg\ --vimgrep
set grepformat=%f:%l:%c:%m

command! -nargs=* -complete=dir Grep silent grep <f-args>
