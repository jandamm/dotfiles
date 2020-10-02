if exists('g:loaded_command')
	finish
endif
let g:loaded_command = 1

command! -bang -nargs=* Terminal call my#command#terminal(<bang>0, <q-args>)

command! -bang -nargs=? -complete=compiler Lmake call my#command#lmake(<bang>0, <f-args>)
" Like Lmake but for the qflist.
" Make either opens a terminal + qf or does nothing.
" Lmake opens the list or not and never shows a terminal
command! -bang -nargs=? -complete=compiler Amake call my#command#amake(<bang>0, <f-args>)

command! -bar BD Sayonara!

" Command to set my default tabwidth etc.
command! IndentDefault call my#format#default()

" Swap two words (bang for strings)
command! -bang -range -nargs=+ Swap call my#command#swap(<bang>0,<line1>,<line2>,<f-args>)

command! -nargs=? Tree  call my#command#tree(0,<f-args>)
command! -nargs=? Vtree call my#command#tree(1,<f-args>)

command! X !chmod +x %
