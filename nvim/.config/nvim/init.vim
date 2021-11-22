scriptencoding utf-8

" This makes loading lua plugins much faster.
lua require('impatient')
lua require('my.lua')

" In this file should be no executed code. Only `let` and `set`

" Appearance {{{

set termguicolors

if !has('gui_running')
	set guioptions=M
endif

set number

" Will be adjusted to be enabled only in the active window
set relativenumber cursorline

set colorcolumn=120

set signcolumn=yes

" }}}

" Wild Menu Completion {{{

set wildmenu
set wildignorecase
set wildmode=longest:full,full

set wildignore+=.root,.tagroot,.vimroot                " Custom project root marker
set wildignore+=.hg,.git,.svn                          " Version control
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg         " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest,*.pyc " compiled object files
set wildignore+=*.spl,*.zwc                            " compiled files
set wildignore+=tags,*.orig
set wildignore+=Pods/*,*.xcassets/*

" }}}

" Editor {{{

" Default path for generic projects
set path=.,**

" Increase time for keyboard shortcuts a bit (default: 1000)
set timeoutlen=1200

set updatetime=100

" Allow changed files to be hidden
set hidden

" Set split commands work more as expected
set splitbelow
set splitright

" Spacing
set noexpandtab " Use tabs
set shiftwidth=2 " Size of shifting code
set tabstop=2 " Size of Tab
let g:detectindent_preferred_indent = 2

" Show statusline always
set laststatus=2

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
set nojoinspaces

" Allow folder specific tags with .root or .tagroot file
let g:gutentags_project_root=['.root', '.tagroot']
" Don't print current dir
let g:rooter_silent_chdir = 1
" Prefer .root file over .vimroot over submodule over .git folder
let g:rooter_patterns = ['.root', '.vimroot', '.git', '.git/']
" Change cwd for current window only
let g:rooter_cd_cmd = 'lcd'

" Always show two lines above/below the cursor
set scrolloff=2

" Persist undo
set undofile

" }}}

" Misc {{{

" Python path
let g:python3_host_prog = '/usr/local/bin/python3'

" Ensure g:projectionist_heuristics is set to modify it in plugin files
let g:projectionist_heuristics = {}

" Check for file specific vim settings in the last 3 lines of the file
set modeline
set modelines=3

" Enable Mouse
set mouse=a

" Do not redraw screen while executing macros
set lazyredraw

" }}}

" Search {{{

set incsearch
set ignorecase
set smartcase

" Highlight/preview replaces
if has('nvim')
	set inccommand=split
endif

" }}}
