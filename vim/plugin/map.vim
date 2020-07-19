" Correct Y yank behavior
nnoremap Y y$

" Esc clears last search
nnoremap <silent> <ESC> :nohlsearch<CR>

" Remap U Redo
nnoremap U <C-r>

nnoremap <silent> gO :call my#keybinds#gO()<CR>

nnoremap <silent> [w :tabprevious<CR>
nnoremap <silent> ]w :tabnext<CR>
nnoremap <silent> [W :tabfirst<CR>
nnoremap <silent> ]W :tablast<CR>

" Insert mode

" Make i_CTRL-u and w undoable, C-u also kills whole line
inoremap <C-u> <C-g>u<C-u><C-o>"_D
inoremap <C-w> <C-g>u<C-w>

" Visual mode

" Quick replace with s
xnoremap s :s/

xnoremap * :<C-u>call my#keybinds#visualSearch('/')<CR>/<C-r>=@/<CR><CR>
xnoremap # :<C-u>call my#keybinds#visualSearch('?')<CR>/<C-r>=@/<CR><CR>

" Repeat replace
nnoremap & :&&<CR>
xnoremap & :&&<CR>

" Command line {{{

" Use C-a to jump to the beginning of ex cmdline
cnoremap <C-a>      <C-b>
" Use default C-a (expand all matching) with C-x C-a
cnoremap <C-X><C-A> <C-A>
" Switch C-p/n with UP/DOWN
cnoremap <C-p>      <UP>
cnoremap <UP>       <C-p>
cnoremap <C-n>      <DOWN>
cnoremap <DOWN>     <C-n>

" %% to current dir in ex mode
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" }}}

" Signify hunk text object {{{

omap ic <Plug>(signify-motion-inner-pending)
xmap ic <Plug>(signify-motion-inner-visual)
omap ac <Plug>(signify-motion-outer-pending)
xmap ac <Plug>(signify-motion-outer-visual)

" }}}

" Completion {{{

" Use Enter to comfirm completion
" Enter twice adds newline without comment
let g:endwise_no_mappings=1
inoremap <expr>   <CR>    my#keybinds#EnterEnter()

" Tab for indent otherwise shiftwidth spaces
imap <expr> <TAB>   vsnip#available(1)  ? '<Plug>(vsnip-expand)'         : my#keybinds#SmartTab()
xmap        <TAB>   <Plug>(vsnip-select-text)c
" Also expand snippets in SELECT mode.
smap <expr> <TAB>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : ''

inoremap <expr>   <S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"

imap              <C-s>   <C-x><C-p>

imap     <expr>   <C-f>   vsnip#available(1)  ? '<Plug>(vsnip-jump-next)' : '<C-x><C-f>'
smap     <expr>   <C-f>   vsnip#available(1)  ? '<Plug>(vsnip-jump-next)' : '<C-f>'

imap     <expr>   <C-b>   vsnip#available(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-b>'
smap     <expr>   <C-b>   vsnip#available(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-b>'

imap     <expr>   <C-t>   pumvisible() ? '<Plug>(ctrlp_complete)' : '<C-t>'

" }}}

" Easy Align {{{

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(LiveEasyAlign)
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(LiveEasyAlign)

" Set ga to gA (ga is vim-align, gA is print ascii)
nnoremap gA ga

" }}}

" Easymotion {{{

let g:EasyMotion_keys='arsdheiqwfpgjlu;yzxcvbkmtno'
map gs <Plug>(easymotion-prefix)
nmap gs<Space> <Plug>(easymotion-overwin-w)
xmap gs<Space> gsw
omap gs<Space> gsw

" }}}

" vim:set foldmethod=marker:
