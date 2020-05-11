let w:no_whitespace_error=1
call my#spelling#en()
call my#format#git()

let g:UltiSnipsRemoveSelectModeMappings = 0

" Jump with UltiSnips defaults
nmap <buffer> <C-f> i<C-f>
nmap <buffer> <C-b> i<C-b>

" Jump forward with TAB
" Expand or Jump
nmap <buffer> <TAB> A<C-R>=(my#keybinds#UltiExpand() > 0) ? '' : UltiSnips#JumpForwards()<CR>
imap <buffer> <TAB> <C-f>
smap <buffer> <TAB> <C-f>

" Jump backwards with Shift TAB
nmap <buffer> <S-TAB> <C-b>
imap <buffer> <S-TAB> <C-b>
smap <buffer> <S-TAB> <C-b>
