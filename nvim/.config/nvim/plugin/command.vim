if exists('g:loaded_command')
	finish
endif
let g:loaded_command = 1

command! -bang -nargs=* Terminal call my#command#terminal(<bang>0, <q-args>)

command! -bar BD Sayonara!

" Command to set my default tabwidth etc.
command! IndentDefault call my#format#default()

" Swap two words (bang for strings)
command! -bang -range -nargs=+ Swap call my#command#swap(<bang>0,<line1>,<line2>,<f-args>)

" Search for a pattern and replace the next search with the pattern
" `SubstituteSubrange My.*Try y i` will replace all `y` between and within My and Try with `i`
command! -range -nargs=+ SubstituteSubrange call my#command#substitute_range(<line1>,<line2>,<f-args>)

command! -nargs=? Tree  call my#command#tree(0,<f-args>)
command! -nargs=? Vtree call my#command#tree(1,<f-args>)

command! X !chmod +x "%"
