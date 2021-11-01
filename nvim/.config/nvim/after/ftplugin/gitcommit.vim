call my#spelling#en()
call my#format#git()

" Jump with luasnip defaults
nmap <buffer> <C-f> i<TAB>
nmap <buffer> <C-b> i<S-TAB>

noremap C "_C

" Jump forward with TAB
" Expand or Jump
nmap <buffer>          <TAB> A<Plug>luasnip-expand-or-jump
imap <buffer> <expr>   <TAB> luasnip#jumpable(1)  ? '<Plug>luasnip-jump-next' : my#map#key#tab()
smap <buffer> <expr>   <TAB> luasnip#jumpable(1)  ? '<Plug>luasnip-jump-next' : '<TAB>'

" Jump backwards with Shift TAB
nmap <buffer>        <S-TAB> i<Plug>luasnip-jump-prev
imap <buffer> <expr> <S-TAB> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<S-TAB>'
smap <buffer> <expr> <S-TAB> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<S-TAB>'
