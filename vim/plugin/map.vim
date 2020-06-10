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

" Move visual selection (This overwrites joining lines)
xnoremap J :m '>+1<CR>gv=gv
xnoremap K :m '<-2<CR>gv=gv

" Command line {{{

" Use C-a to jump to the beginning of ex cmdline
cnoremap <C-a>  <C-b>
" Switch C-p/n with UP/DOWN
cnoremap <C-p>  <UP>
cnoremap <UP>   <C-p>
cnoremap <C-n>  <DOWN>
cnoremap <DOWN> <C-n>

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
inoremap <expr> <CR> my#keybinds#EnterEnter()

" Tab for indent otherwise shiftwidth spaces
inoremap <silent> <TAB>   <C-R>=(my#keybinds#UltiExpand() > 0) ? '' : my#keybinds#SmartTab()<CR>
" Default xmap for UltiSnips
xnoremap <silent> <TAB>   :call UltiSnips#SaveLastVisualSelection()<CR>gvs
" Also expand snippets in SELECT mode.
snoremap <silent> <TAB>   <ESC>a<C-R>=(my#keybinds#UltiExpand() > 0) ? '' : my#keybinds#reselectAfterUltiSnips()<CR>

" Shift Tab for next/previous in pum else UltiSnips
inoremap <expr>   <S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"

" }}}

" UltiSnips {{{

" Use own mappings for UltiSnips Expand
let g:UltiSnipsExpandTrigger='<NUL>'
let g:UltiSnipsJumpForwardTrigger='<C-f>'
let g:UltiSnipsJumpBackwardTrigger='<C-b>'

" UltiSnips removes some keymappings of select mode.
let g:UltiSnipsRemoveSelectModeMappings = 1
let g:UltiSnipsMappingsToIgnore = ['my#keybinds#']

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
