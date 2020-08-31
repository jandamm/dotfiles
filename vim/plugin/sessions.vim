if exists('g:loaded_session_cmds')
	finish
endif
let g:loaded_session_cmds = 1

command! Mksession call my#sessions#make()
command! -nargs=? Session call my#sessions#load(<q-args>)
command! -nargs=? Rmsession call my#sessions#delete(<q-args>)

command! CtrlPSession call ctrlp#init(ctrlp#sessions#id())
