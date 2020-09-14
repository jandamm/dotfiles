if exists('g:loaded_commands') | finish | endif
let g:loaded_commands = 1

command! -nargs=* Terminal vsplit <BAR> terminal <args>

" Command to set my default tabwidth etc.
command! IndentDefault call my#format#default()

" Swap two words (bang for strings)
command! -bang -range -nargs=+ Swap call my#command#swap(<bang>0,<line1>,<line2>,<f-args>)

command! -nargs=? Tree  call my#command#tree(0,<f-args>)
command! -nargs=? Vtree call my#command#tree(1,<f-args>)

command! X !chmod +x %
