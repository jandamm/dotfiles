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

colorscheme one
set t_8b=^[[48;2;%lu;%lu;%lum
set t_8f=^[[38;2;%lu;%lu;%lum
let g:one_allow_italics=1
set background=dark

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
set listchars=tab:>-,trail:·
set list

" Mark trailing whitespace as error (red)
let w:m2=matchadd('ErrorMsg', '\s\+$', -1)

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
nmap <esc><esc> :noh<cr>:<bs>

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
