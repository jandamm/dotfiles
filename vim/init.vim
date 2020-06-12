scriptencoding utf-8

" In this file should be no executed code. Only `let` and `set`

" Appearance {{{

if has('termguicolors')
	set termguicolors
endif

if !has('nvim')
	let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
	let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

let g:one_allow_italics=1
colorscheme one

if !has('gui_running')
	set guioptions=M
endif

set number
set relativenumber

set colorcolumn=120,160

set signcolumn=yes
let g:signify_sign_change = '△'

" }}}

" Wild Menu Completion {{{

set wildmode=longest:full,full
set wildignore+=.root                                  " Custom project root marker
set wildignore+=.hg,.git,.svn                          " Version control
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg         " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest,*.pyc " compiled object files
set wildignore+=*.spl,*.zwc                            " compiled files
set wildignore+=tags,.tags
set wildmenu
set wildoptions-=pum

" }}}

" Editor {{{

" Increase time for keyboard shortcuts a bit (default: 1000)
set timeoutlen=1200

" Update signify after x ms
set updatetime=100

" Allow changed files to be hidden
set hidden

" Set split commands work more as expected
set splitbelow
set splitright
let g:UltiSnipsEditSplit='vertical'

let g:UltiSnipsSnippetDirectories=['PrivateSnips', 'UltiSnips']

" Spacing
set tabstop=2 " Size of Tab

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

" Allow folder specific tags with .root file
let g:gutentags_project_root=['.root']
" Hide tags file
let g:gutentags_ctags_tagfile='.tags'
" Prefer .root file over submodule over .git folder
let g:rooter_patterns = ['.root', '.git', '.git/']
" Change cwd for current window only
let g:rooter_use_lcd = 1

" Default hide hidden files in netrw (toggle with gh)
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'

" Always show two lines above/below the cursor
set scrolloff=2

" Persist undo
if has('persistent_undo')
	set undodir=$DOTFILES_CACHE/vim/undodir
	set undofile
endif

" }}}

" Misc {{{

" Python path
let g:python3_host_prog = '/usr/local/bin/python3'

" Check for file specific vim settings in the last 3 lines of the file
set modeline
set modelines=3

" Enable Mouse
set mouse=a

" Do not redraw screen while executing macros
set lazyredraw

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

" Highlight/preview replaces
if has('nvim')
	set inccommand=split
endif

" }}}

" vim:set foldmethod=marker:
