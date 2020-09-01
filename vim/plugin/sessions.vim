if exists('g:loaded_session_cmds')
	finish
endif
let g:loaded_session_cmds = 1

command! -bang Mksession call my#sessions#make(<bang>0)

command! -bang -nargs=? -complete=customlist,my#sessions#complete Session   call my#sessions#load(<bang>0, <q-args>)
command!       -nargs=? -complete=customlist,my#sessions#complete Rmsession call my#sessions#delete(<q-args>)

command! CtrlPSession call ctrlp#init(ctrlp#sessions#id())
