" vim:set foldmethod=marker:

" Plugins {{{

call plug#begin('~/.local/share/nvim/plugged')

" Usage
Plug 'tpope/vim-surround'
Plug 'justinmk/vim-sneak'

" Search
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

" Themes
Plug 'joshdick/onedark.vim'

" User Interface
Plug 'ap/vim-buftabline'
Plug 'mhinz/vim-signify'

" Tmux
"Plug 'christoomey/vim-tmux-navigator'
"Plug 'christoomey/vim-tmux-runner'

" Auto Completion
Plug 'dustinknopoff/TeaCode-Vim-Extension'
Plug 'SirVer/ultisnips'
Plug 'prabirshrestha/asyncomplete.vim'

" LSP
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'thomasfaingnaert/vim-lsp-snippets'
Plug 'thomasfaingnaert/vim-lsp-ultisnips'

" Languages
Plug 'keith/swift.vim', { 'for': 'swift' }
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }

" Misc
" Asynchronous file linting/formatting
"Plug 'w0rp/ale'

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
nmap <s-cr> O<esc>Dj

" Correct Y yank behavior
nmap Y y$

" Esc twice to clear last search
nmap <esc><esc> :noh<cr>

" Remap U Redo
nnoremap U <C-r>

" What does this mapping?
"xmap s S

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
