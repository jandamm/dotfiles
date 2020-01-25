" vim:set foldmethod=marker:

" Load plugins (Extracted to file to ease first installation)
runtime plugins.vim

" Appearance {{{

" Git Bar always visible
set signcolumn=yes

" Buffer Tabs
let g:buftabline_show=1

if (has("termguicolors"))
	set termguicolors
endif

set background=dark
colorscheme one
let g:one_allow_italics=1
autocmd VimEnter * ++once call one#highlight('gitcommitSummary', 'e5c07b', '', 'none')
highlight link gitcommitOverflow ErrorMsg

set laststatus=0

" TabLine Theming
"hi TabLine guifg=#abb2bf
"hi TabLineSel guibg=#61afef
"hi TabLineSel guifg=#282c34

" enable syntax highligthing
syntax on

set guioptions=M
set number
set relativenumber

set colorcolumn=120,160

" }}}

" Completion {{{

" TODO: Move to ftplugin/swift.vim
if executable('sourcekit-lsp')
	au User lsp_setup call lsp#register_server({
				\ 'name': 'sourcekit-lsp',
				\ 'cmd': {server_info->['sourcekit-lsp']},
				\ 'whitelist': ['swift'],
				\ })
endif

" Use asyncomplete as omnifunc without auto hud.
" Map omnicomplete shortcut to asyncomplete
imap <c-x><c-o> <Plug>(asyncomplete_force_refresh)
" Disable asyncomplete auto popup
let g:asyncomplete_auto_popup = 0
let g:asyncomplete_popup_delay = 0
" Set my own completeopt instead of asyncomplete
let g:asyncomplete_auto_completeopt = 0
set completeopt=menu,preview

" Use Enter to comfirm completion
inoremap <silent><expr> <cr> pumvisible() ? "\<C-y>" : "\<cr>"

" Use c-cr as omnicomplete
imap <c-cr> <c-x><c-o>

" Use tabs for UltiSnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" TeaCode Shortcut
inoremap <C-M-e> <C-O>:call TeaCodeExpand()<CR>

" Simple Menu Completion
set wildmode=longest:full,full
set wildignore+=.hg,.git,.svn                          " Version control
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg         " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest,*.pyc " compiled object files
set wildignore+=tags,.tags
set wildmenu

" }}}

" Editor {{{

" Allow changed files to be hidden
set hidden

" Set spelling language
set spelllang=en_us

" Set split commands work more as expected
set splitbelow
set splitright

" Spacing
" https://vim.fandom.com/wiki/Indent_with_tabs,_align_with_spaces
set noexpandtab " Use Tabs
set tabstop=2 " Size of Tab
set shiftwidth=2 " Size of Tab input with <TAB>
set softtabstop=0
set cindent
set cinoptions=(0,u0,U0

" Show tabs and trailing whitespace
set listchars=tab:⟩‐,trail:·
set list

" Wrapping lines
set wrap
set linebreak
if exists('+breakindent')
  set breakindent
  set breakindentopt=shift:2
endif

autocmd VimEnter * call neomake#configure#automake('nw', 500)

" }}}

" Keybindings {{{

" Buffer/Tab navigation
noremap <c-n> :bn<cr>
noremap <c-p> :bp<cr>

" New Line in normal mode
noremap <cr> o<C-u><esc>k
noremap <s-cr> O<C-u><esc>j

" Enter and comments
function! EnterEnter()
  if getline(".") =~ '^\s*\(//\|#\|"\)\s*$'
    return "\<C-u>"
  else
    return "\<CR>"
  endif
endfunction

imap <expr> <CR> EnterEnter()
imap <S-CR> <CR><C-u>

" Correct Y yank behavior
nmap Y y$

" Esc twice to clear last search
noremap <esc><esc> :noh<cr>:<bs>

" Remap U Redo
nnoremap U <C-r>

" Use surround.vim with s
xmap s S

" Sneak:
" Always include first typed character
onoremap <silent> z :call sneak#wrap(v:operator, 2, 0, 1, 1)<cr>
" Use z and Z in visual mode
xnoremap <silent> z :call sneak#wrap(visualmode(), 2, 0, 1, 1)<cr>
xnoremap <silent> Z :call sneak#wrap(visualmode(), 2, 1, 1, 1)<cr>

" }}}

" Keybindings Leader {{{

" Use Space & \ as Leader
nmap <Space> <Leader>

" Leader Keybindings
nmap <Leader>bb :Buffers<cr>
nmap <Leader>bd :bd<cr>
nmap <Leader>qq :q<cr>
nmap <Leader>bn :bn<cr><esc>
nmap <Leader>bp :bp<cr><esc>
nmap <Leader><Space> :Files<cr>

nmap <Leader>e :lnext<cr>
nmap <Leader>E :lprev<cr>

" }}}

" Misc {{{

" Check for file specific vim settings in the last 3 lines of the file
set modeline
set modelines=3

" Enable Mouse
set mouse=a

" Syntax
syntax on

" Clipboard
if has('clipboard')     " If the feature is available
  set clipboard=unnamed " copy to the system clipboard

  if has('unnamedplus')
    set clipboard+=unnamedplus
  endif
endif

" }}}

" Search {{{

set incsearch
set ignorecase
set smartcase

" }}}
