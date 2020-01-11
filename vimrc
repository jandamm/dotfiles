call plug#begin('~/.local/share/nvim/plugged')
" Usage {{{
Plug 'tpope/vim-surround'
Plug 'justinmk/vim-sneak'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
" }}}

" Themes {{{
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'joshdick/onedark.vim'
Plug 'rakr/vim-one'
" }}}

" User Interface {{{
"Plug 'itchyny/lightline.vim'
Plug 'ap/vim-buftabline'

Plug 'mhinz/vim-signify'
"Plug 'dpc/vim-smarttabs'
" }}}

" Auto Completion {{{
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-bufword'
if strlen($TMUX) && executable('tmux')
  Plug 'ncm2/ncm2-tmux'
endif
Plug 'ncm2/ncm2-path', { 'for': ['sh', 'zsh', 'nvim', 'vim'] }
Plug 'dustinknopoff/TeaCode-Vim-Extension'
" }}}

" Syntax Highlighting {{{
Plug 'keith/swift.vim', { 'for': 'swift' }
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }
" }}}
call plug#end()


" filetypes
au BufRead,BufNewFile *.tmux set filetype=tmux
au BufRead,BufNewFile *file set filetype=ruby " Podfile, Appfile, Matchfile, Fastfile
autocmd FileType * setlocal noexpandtab
au BufRead,BufNewFile .swiftlint.yml set expandtab

set guioptions=M
set number
set relativenumber

set colorcolumn=140,200

" Set split commands work more as expected
set splitbelow
set splitright

imap <c-x><c-x> <c-x><c-o>

" Spacing
" https://vim.fandom.com/wiki/Indent_with_tabs,_align_with_spaces
set noexpandtab " Use Tabs
set tabstop=2 " Size of Tab
set shiftwidth=2 " Size of Tab input with <TAB>
set softtabstop=0
set cindent
set cinoptions=(0,u0,U0

" Wrapping lines
set wrap
set linebreak
if exists('+breakindent')
  set breakindent
  set breakindentopt=shift:2
endif

" Check for file specific vim settings in the last 3 lines of the file
set modeline
set modelines=3

" Search
set incsearch
set ignorecase
set smartcase

" Simple Menu Completion
set wildmode=longest:full,full
set wildignore+=.hg,.git,.svn                          " Version control
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg         " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest,*.pyc " compiled object files
set wildignore+=tags,.tags
set wildmenu

" Enable Mouse
set mouse=a

" Disable mode (Airline)
" set noshowmode

" Syntax
syntax on


" Use Space & \ as Leader
nmap <Space> <Leader>

" Leader Mappings
nmap <Leader>bb :Buffers<cr>
nmap <Leader>bd :bd<cr>
nmap <Leader>qq :q<cr>
nmap <Leader>bn :bn<cr><esc>
nmap <Leader>bp :bp<cr><esc>
nmap <Leader><Space> :Files<cr>

" Buffer/Tab navigation
nmap <c-w><c-p> :bn<cr>
nmap <c-w><c-f> :bp<cr>

" New Line in normal mode
nmap <cr> o<esc>Dk

" Correct Y yank behavior
nmap Y y$

" Remap U to C-R
nnoremap U <C-r>
xmap s S

" TeaCode Shortcut
inoremap <C-M-e> <C-O>:call TeaCodeExpand()<CR>

" Shortcuts for ncm2
inoremap <silent> <expr> <CR> (pumvisible() ? "\<c-y>" : "\<CR>")
inoremap <silent> <expr> <TAB> (pumvisible() ? "\<c-y>" : "\<TAB>")

" enable ncm2 for all buffers
"autocmd BufEnter * call ncm2#enable_for_buffer()

set shortmess+=c
let g:ncm2#filter='same_word'
let g:ncm2#popup_limit=20

"set completeopt=noinsert,menuone

" Git Bar always visible
set signcolumn=yes

" Buffer Tabs
let g:buftabline_show=1

if (has("termguicolors"))
	set termguicolors
endif

syntax on
let g:onedark_termcolors=256
colorscheme onedark
set background=dark

let g:lightline = {
  \ 'colorscheme': 'one',
  \ }

" More prominent line color
hi LineNr guifg=#5c6370

