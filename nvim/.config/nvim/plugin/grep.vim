if exists('g:loaded_grep')
	finish
endif
let g:loaded_grep = 1

set grepprg=ack\ -s\ -H\ --column
set grepformat=%f:%l:%c:%m,%f:%l:%m

command! -bang -nargs=+ -complete=dir Ack   call my#grep#command(<bang>0, 0, 0, 'c', <q-args>)
command! -bang -nargs=+               Grep  call my#grep#command(<bang>0, 0, 1, 'c', <q-args>)
command! -bang -nargs=+               Lgrep call my#grep#command(<bang>0, 0, 1, 'l', <q-args>)
command! -bang -nargs=+ -complete=dir Rg    call my#grep#command(<bang>0, 0, 2, 'c', <q-args>)

nnoremap <silent> g/ :set operatorfunc=my#grep#operator<CR>g@
xnoremap <silent> g/ :<C-u>silent call my#grep#operator(visualmode())<CR>
