scriptencoding utf-8

" Load plugins (Extracted to file to ease first installation)
runtime plugins.vim

" Appearance {{{

" Git Bar always visible
set signcolumn=yes
let g:signify_sign_change = '△'

if (has('termguicolors'))
	set termguicolors
endif

if !has('nvim')
	let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
	let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

set background=dark
colorscheme one
let g:one_allow_italics=1
autocmd VimEnter * ++once call one#highlight('gitcommitSummary', 'e5c07b', '', 'none')
autocmd VimEnter * ++once call one#highlight('User1', '61afef', '2c323c', 'none')
autocmd VimEnter * ++once call one#highlight('User2', 'e06c75', '2c323c', 'none')
autocmd VimEnter * ++once hi clear StatuslineNC " Quick fix for inactive statusline
highlight link gitcommitOverflow Error
autocmd VimEnter * ++once highlight link NeomakeVirtualtextError ErrorMsg

" TabLine Theming
"hi TabLine guifg=#abb2bf
"hi TabLineSel guibg=#61afef
"hi TabLineSel guifg=#282c34

let g:neomake_info_sign = {
			\ 'text': 'i',
			\ 'texthl': 'NeomakeInfoSign'
			\ }

if !has('gui_running')
	set guioptions=M
endif
set number
set relativenumber

set colorcolumn=120,160

" }}}

" Completion {{{

" Use asyncomplete as omnifunc without auto hud.
" Disable asyncomplete auto popup
let g:asyncomplete_auto_popup = 0
let g:asyncomplete_popup_delay = 0
" Enable only with sources
let g:asyncomplete_enable_for_all = 0
" Set my own completeopt instead of asyncomplete
let g:asyncomplete_auto_completeopt = 0

" Use own mappings for UltiSnips Expand
let g:UltiSnipsExpandTrigger='<NUL>'
let g:UltiSnipsJumpForwardTrigger='<C-f>'
let g:UltiSnipsJumpBackwardTrigger='<C-b>'

" Simple Menu Completion
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

" Allow changed files to be hidden
set hidden
augroup auto_save_files
	au!
	" Save all changed files when Vim is put to background.
	" Silently because buffers without name cannot be saved.
	autocmd FocusLost * silent! wall | echo 'Saved all modified files'
augroup END

" Set split commands work more as expected
set splitbelow
set splitright
let g:UltiSnipsEditSplit='vertical'

let g:UltiSnipsSnippetDirectories=['PrivateSnips', 'UltiSnips']

" Markdown syntax doesn't work good with polyglot yet.
" Enable when Theme is tweaked to work nicely.
let g:polyglot_disabled = ['markdown']

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

" Update signify after x ms
set updatetime=100

" Allow folder specific tags with .root file
let g:gutentags_project_root=['.root']
" Prefer .root file over submodule over .git folder
let g:rooter_patterns = ['.root', '.git', '.git/']
" Change cwd for current window only
let g:rooter_use_lcd = 1

" Default hide hidden files in netrw (toggle with gh)
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'

" Always show two lines above/below the cursor
set scrolloff=2

let g:lsp_diagnostics_enabled = 0
call neomake#configure#automake('rnw', 500)

" }}}

" Keybindings {{{

map <F13> [
map <C-F13> <C-[>
map <F16> ]
map <C-F16> <C-]>

" Buffer/Tab navigation
nnoremap <C-n> :bn<CR>
nnoremap <C-p> :bp<CR>

" Use C-a to jump to the beginning of ex cmdline
cnoremap <C-a>  <C-b>
" Switch C-p/n with UP/DOWN
cnoremap <C-p>  <UP>
cnoremap <UP>   <C-p>
cnoremap <C-n>  <DOWN>
cnoremap <DOWN> <C-n>

" %% to current dir in ex mode
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" Signify hunk text object
omap ic <Plug>(signify-motion-inner-pending)
xmap ic <Plug>(signify-motion-inner-visual)
omap ac <Plug>(signify-motion-outer-pending)
xmap ac <Plug>(signify-motion-outer-visual)

" Tab for indent otherwise shiftwidth spaces
inoremap <silent> <TAB>   <C-R>=(my#keybinds#UltiExpand() > 0) ? '' : my#keybinds#SmartTab()<CR>
" Default xmap for UltiSnips
xnoremap <silent> <TAB>   :call UltiSnips#SaveLastVisualSelection()<CR>gvs
let g:UltiSnipsRemoveSelectModeMappings = 1
let g:UltiSnipsMappingsToIgnore = ['my#keybinds#']
" Also expand snippets in SELECT mode.
snoremap <silent> <TAB>   <ESC>a<C-R>=(my#keybinds#UltiExpand() > 0) ? '' : my#keybinds#reselectAfterUltiSnips()<CR>

" Shift Tab for next/previous in pum else UltiSnips
inoremap <expr>   <S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"

" Use Enter to comfirm completion
" Enter twice adds newline without comment
let g:endwise_no_mappings=1
inoremap <expr> <CR> my#keybinds#EnterEnter()

" Correct Y yank behavior
nmap Y y$

" Esc twice to clear last search
nnoremap <ESC><ESC> :nohlsearch<CR>:<BS>

" Remap U Redo
nnoremap U <C-r>

" Make i_CTRL-u and w undoable
inoremap <C-u> <C-g>u<C-u>
inoremap <C-w> <C-g>u<C-w>

" Use surround.vim with s
xnoremap s :s/

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Easymotion on gs
map gs <Plug>(easymotion-prefix)
map gs<Space> <Plug>(easymotion-overwin-w)
let g:EasyMotion_keys='arsdheiqwfpgjlu;yzxcvbkmtno'

" Set ga to gA (ga is vim-align, gA is print ascii)
nnoremap gA ga

" }}}

" Keybindings Leader {{{

func s:NotDefined(type)
	return '{' . a:type . '} is not defined for [' . &filetype . ']'
endfunc

" Use Space & \ as Leader
nmap <SPACE> <Leader>

" Leader Keybindings
" Some mappings should be overwritten in ftplugins
" Mainly c, f, r, u
nmap <Leader>b          :Buffers<CR>
nmap <Leader>c          :echo <SID>NotDefined('compiler')<CR>
" d -> Directory
" TODO Only Sexplore if one window
nmap <Leader>d          :Sexplore<CR>
" f -> Format
nmap <Leader>f          :%s/\s\+$//e<CR>:let @/=''<CR>:noh<CR>gg=G``zz
" Fugitive/Git
nmap <Leader>gb         :GSwitch<CR>
nmap <Leader>gB         :GSwitchAll<CR>
nmap <Leader>gc         :Gcommit<CR>
nmap <Leader>gd         :Gvdiffsplit!<CR>
nmap <Leader>gf         :Gfetch<CR>
nmap <Leader>gF         :Gpull<CR>
nmap <expr> <Leader>gg ':Git '
" h -> Hunk
nmap <Leader>ghd        :SignifyHunkDiff<CR>
nmap <Leader>ghu        :SignifyHunkUndo<CR>
nmap <Leader>glf        :0Glog<CR>
nmap <Leader>gll        :Glog<CR>
nmap <Leader>gm         :Gmerge<CR>
nmap <Leader>gp         :Gpush<CR>
nmap <Leader>gr         :Grebase<CR>
nmap <Leader>gs         :Gstatus<CR>
" w -> Who did this?
nmap <Leader>gw         :Gblame<CR>
" TODO Replace l with lopen, select window, lclose
nmap <Leader>l          <Plug>window:quickfix:loop
" o -> Outline
nmap <Leader>o          :TagbarToggle<CR>
nmap <Leader>r          :echo <SID>NotDefined('run')<CR>
nmap <Leader>s          :call my#keybinds#Spell()<CR>
nmap <Leader>t          :Tags<CR>
" u -> Unit test
nmap <Leader>u          :echo <SID>NotDefined('test')<CR>
" TODO Replace with GFiles if in git
nmap <Leader><SPACE>    :Files<CR>
nmap <Leader>/          :Lines<CR>
nmap <expr> <Leader>?  ':Rg '

" }}}

" Misc {{{

" Check for file specific vim settings in the last 3 lines of the file
set modeline
set modelines=3

" Enable Mouse
set mouse=a

" Do not redraw screen while executing macros
set lazyredraw

" Highlight/preview replaces
if has('nvim')
	set inccommand=nosplit
endif

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

" vim:set foldmethod=marker:
