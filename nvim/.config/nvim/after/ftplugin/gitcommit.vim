call my#spelling#en()
call my#format#git()

" Jump with vsnips defaults
nmap <buffer> <C-f> i<TAB>
nmap <buffer> <C-b> i<S-TAB>

" Jump forward with TAB
" Expand or Jump
nmap <buffer>          <TAB> A<Plug>(vsnip-expand-or-jump)
imap <buffer> <expr>   <TAB> vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : my#map#key#tab()
smap <buffer> <expr>   <TAB> vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<TAB>'

" Jump backwards with Shift TAB
nmap <buffer>        <S-TAB> i<Plug>(vsnip-jump-prev)
imap <buffer> <expr> <S-TAB> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-TAB>'
smap <buffer> <expr> <S-TAB> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-TAB>'
