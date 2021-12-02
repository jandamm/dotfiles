nnoremap ; :
xnoremap ; :
onoremap ; :
nnoremap @; @:

" Remap U Redo
nnoremap U <C-r>

nnoremap <silent> gO :call my#map#outline()<CR>

" Poor mans Rename - no LSP (rename)
nnoremap <expr> gR ":\<C-u>%s/\\<".escape(expand('<cword>'), '/') ."\\>//g\<Left>\<Left>"
xnoremap <expr> gR ":\<C-u>%s/\\<".escape(expand('<cword>'), '/') ."\\>//g\<Left>\<Left>"

" Better mappings for diag/qf/loc list
nmap [d <CMD>lua vim.diagnostic.goto_prev({float=false})<CR>
nmap ]d <CMD>lua vim.diagnostic.goto_next({float=false})<CR>
nmap [l <Plug>(qf_loc_previous)
nmap ]l <Plug>(qf_loc_next)
nmap [q <Plug>(qf_qf_previous)
nmap ]q <Plug>(qf_qf_next)

nnoremap <silent> [w :tabprevious<CR>
nnoremap <silent> ]w :tabnext<CR>
nnoremap <silent> [W :tabfirst<CR>
nnoremap <silent> ]W :tablast<CR>

" Quickly jump to window number
nnoremap <C-w>1 <CMD>1wincmd w<CR>
nnoremap <C-w>2 <CMD>2wincmd w<CR>
nnoremap <C-w>3 <CMD>3wincmd w<CR>
nnoremap <C-w>4 <CMD>4wincmd w<CR>
nnoremap <C-w>5 <CMD>5wincmd w<CR>
nnoremap <C-w>6 <CMD>6wincmd w<CR>
nnoremap <C-w>7 <CMD>7wincmd w<CR>
nnoremap <C-w>8 <CMD>8wincmd w<CR>
nnoremap <C-w>9 <CMD>9wincmd w<CR>

" Insert mode

" Make i_CTRL-u and w undoable, C-u also kills whole line
inoremap <C-u> <C-g>u<C-u><C-o>"_D
inoremap <C-w> <C-g>u<C-w>

" Visual mode

" Quick replace with gr
xnoremap gr :s/

xnoremap < <gv
xnoremap > >gv

" In visual mode p copies the selected text and pastes the previous text.
" Most of the time I don't want this. If I do, I can still use P which does
" the same.
xnoremap <expr> p '"_c<C-r>'.v:register.'<ESC>'

xnoremap * :<C-u>call my#map#visualSearch('/')<CR>/<C-r>=@/<CR><CR>
xnoremap # :<C-u>call my#map#visualSearch('?')<CR>/<C-r>=@/<CR><CR>

" Select mode
" <BS> and <C-w> deletes selection and stays goes into insert mode
snoremap <BS>  <BS>i
snoremap <C-w> <BS>i
" <C-p>/<C-n> start word completion
snoremap <C-p> <BS>i<C-p>
snoremap <C-n> <BS>i<C-n>
" <C-a>/<C-e> go to beginning/end of selection (as long as first char is
" selected)
snoremap <C-a> <ESC>i
snoremap <C-e> <C-g>o<ESC>a

" Repeat replace
nnoremap & :&&<CR>
xnoremap & :&&<CR>

" Buffer local mappings {{{

augroup ft_mappings
	autocmd!
	autocmd Filetype qf,help nnoremap <silent> <buffer> gq <CMD>q<CR>
augroup END

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

" Completion {{{

" TODO: Migrate to cmp config
" Use Enter to comfirm completion
" Enter twice adds newline without comment
let g:endwise_no_mappings=1
inoremap <expr> <CR> my#map#key#enter()

" Tab for indent otherwise shiftwidth spaces
imap <expr> <TAB> my#map#key#tab()

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
