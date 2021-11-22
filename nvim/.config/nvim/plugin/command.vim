command! -bang -nargs=* Terminal call my#command#terminal(<bang>0, <q-args>)

" Command to set my default tabwidth etc.
command! Tabs call my#format#default()

" Swap two words (bang for strings)
command! -bang -range -nargs=+ Swap call my#command#swap(<bang>0,<line1>,<line2>,<f-args>)

" Search for a pattern and replace the next search with the pattern
" `SubstituteSubrange My.*Try y i` will replace all `y` between and within My and Try with `i`
command! -range -nargs=+ SubstituteSubrange call my#command#substitute_range(<line1>,<line2>,<f-args>)

command! -nargs=? Tree  call my#command#tree(0,<f-args>)
command! -nargs=? Vtree call my#command#tree(1,<f-args>)

command! X !chmod +x "%"

command! -bang -nargs=? -range=-1 -complete=customlist,fugitive#Complete GG   Dispatch<bang> git <args>

command! -nargs=? -complete=dir TODO GrepperRg '--hidden' ' (FIXME|FIX|TODO|NOTE):' <f-args>
command! -nargs=? -complete=dir MARK GrepperRg '--hidden' ' MARK:' <f-args>
command! -nargs=? -complete=dir FIX  GrepperRg '--hidden' ' (FIXME|FIX):' <f-args>
