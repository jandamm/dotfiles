" vim:set foldmethod=marker:

" Plugins {{{

call plug#begin('~/.local/share/nvim/plugged')

" Usage
Plug 'tpope/vim-surround'
Plug 'justinmk/vim-sneak'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

" Themes
Plug 'joshdick/onedark.vim'

" User Interface
Plug 'ap/vim-buftabline'
Plug 'mhinz/vim-signify'

" Auto Completion
"Plug 'ncm2/ncm2'
"Plug 'roxma/nvim-yarp'
"Plug 'ncm2/ncm2-bufword'
"if strlen($TMUX) && executable('tmux')
"  Plug 'ncm2/ncm2-tmux'
"endif
"Plug 'ncm2/ncm2-path', { 'for': ['sh', 'zsh', 'nvim', 'vim'] }
Plug 'dustinknopoff/TeaCode-Vim-Extension'

" Languages
Plug 'keith/swift.vim', { 'for': 'swift' }
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }

call plug#end()

" }}}

" Appearance {{{

" Git Bar always visible
set signcolumn=yes

" Buffer Tabs
let g:buftabline_show=1

if (has("termguicolors"))
	set termguicolors
endif

colorscheme onedark
let g:onedark_hide_endofbuffer=0
let g:onedark_termcolors=256
let g:onedark_terminal_italics=0 " Currently doesn't work with my tmux setup
set background=dark

" More prominent line color
hi LineNr guifg=#5c6370

" enable syntax highligthing
syntax on

set guioptions=M
set number
set relativenumber

set colorcolumn=140,200

" }}}

" Completion {{{

imap <c-x><c-x> <c-x><c-o>

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

" Wrapping lines
set wrap
set linebreak
if exists('+breakindent')
  set breakindent
  set breakindentopt=shift:2
endif
" }}}

" Keybindings {{{

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

" }}}

" Misc {{{

" Check for file specific vim settings in the last 3 lines of the file
set modeline
set modelines=3

" Enable Mouse
set mouse=a

" Syntax
syntax on

" }}}

" Search {{{

set incsearch
set ignorecase
set smartcase

" }}}
