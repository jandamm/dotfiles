" No mappings for BufKill
let g:BufKillCreateMappings = 0

" Correct Y yank behavior
nnoremap Y y$

" Esc clears last search
nnoremap <silent> <C-l> :nohlsearch<CR>:diffupdate<CR>:syntax sync fromstart<CR><C-l>

" Remap U Redo
nnoremap U <C-r>

nnoremap <silent> gO :call my#map#outline()<CR>

" Better mappings for qf/loc list
nmap [l <Plug>(qf_loc_previous)
nmap ]l <Plug>(qf_loc_next)
nmap [q <Plug>(qf_qf_previous)
nmap ]q <Plug>(qf_qf_next)

nnoremap <silent> [w :tabprevious<CR>
nnoremap <silent> ]w :tabnext<CR>
nnoremap <silent> [W :tabfirst<CR>
nnoremap <silent> ]W :tablast<CR>

" Insert mode

" Make i_CTRL-u and w undoable, C-u also kills whole line
inoremap        <C-u> <C-g>u<C-u><C-o>"_D
inoremap <expr> <C-w> pumvisible() ? '<C-e>' : '<C-g>u<C-w>'

" Visual mode

" Quick replace with s
xnoremap s :s/

xnoremap < <gv
xnoremap > >gv

" In visual mode p copies the selected text and pastes the previous text.
" Most of the time I don't want this. If I do, I can still use P which does
" the same.
xnoremap <expr> p '"_c<C-r>'.v:register.'<ESC>'

xnoremap * :<C-u>call my#map#visualSearch('/')<CR>/<C-r>=@/<CR><CR>
xnoremap # :<C-u>call my#map#visualSearch('?')<CR>/<C-r>=@/<CR><CR>

" Select mode
" <C-w> deletes selection and stays goes into insert mode
snoremap <C-w> <BS>i
snoremap <C-p> <BS>i<C-p>
snoremap <C-n> <BS>i<C-n>

" Repeat replace
nnoremap & :&&<CR>
xnoremap & :&&<CR>

" Easy Motion {{{

let g:EasyMotion_keys = 'arstneiodhqwfpluygj'
map  <Space><Space> <Plug>(easymotion-prefix)
nmap <ESC><ESC>     <Plug>(easymotion-overwin-line)
omap <Space>        <Plug>(easymotion-prefix)
omap <Space><Space> <Plug>(easymotion-bd-w)

" }}}

" Buffer local mappings {{{

augroup ft_mappings
	autocmd!
	autocmd Filetype qf,help call s:quit_mapping()
	autocmd Filetype gitmessengerpopup call s:gitmess_quit_mapping()
augroup END

function! s:gitmess_quit_mapping() abort
	call s:quit_mapping()
	nnoremap <silent> <buffer> <ESC> <CMD>q<CR>
endfunction
function! s:quit_mapping() abort
	nnoremap <silent> <buffer> gq  <CMD>q<CR>
endfunction

" Show overview of fugitive mappings with g?
let g:fuguidive_map_help = 'g?'

" }}}

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
inoremap <expr>   <CR>    my#map#key#enter()

" Tab for indent otherwise shiftwidth spaces
imap <expr> <TAB>   my#map#key#tab()
xmap        <TAB>   <Plug>(vsnip-cut-text)
" Also expand snippets in SELECT mode.
smap <expr> <TAB>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : ''

inoremap <expr>   <S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"

imap              <C-s>   <C-x><C-p>

imap     <expr>   <C-f>   vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<C-x><C-f>'
smap     <expr>   <C-f>   vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<C-f>'

imap     <expr>   <C-b>   vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-b>'
smap     <expr>   <C-b>   vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-b>'

imap     <expr>   <C-t>   pumvisible() ? '<Plug>(ctrlp_complete)' : '<C-t>'

inoremap <expr>   <C-j>   pumvisible() ? '<C-n>' : '<C-j>'
inoremap <expr>   <C-k>   pumvisible() ? '<C-p>' : '<C-k>'

" }}}

" Tabular {{{

nmap ga :Tabularize<SPACE>/
xmap ga :Tabularize<SPACE>/

nmap gav :Tabularize<SPACE>/\V
xmap gav :Tabularize<SPACE>/\V

for shortcut in [':', '=', ',', '.']
	execute 'nmap ga'.shortcut.' <CMD>Tabularize /\V'.shortcut.'<CR>'
	execute 'xmap ga'.shortcut.' :Tabularize /\V'.shortcut.'<CR>'
endfor

" Set ga to gA (ga is Tabularize, gA is print ascii)
nnoremap gA ga

" }}}

" vim:set foldmethod=marker:
