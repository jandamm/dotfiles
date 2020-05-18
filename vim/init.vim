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
	autocmd FocusLost * :update
augroup END

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

" Command to set my default tabwidth etc.
command! SleuthOverwrite call my#format#default()

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

let g:lsp_diagnostics_enabled = 0
call neomake#configure#automake('rnw', 500)

" }}}

" Keybindings {{{

nnoremap <silent> [w :tabprevious<CR>
nnoremap <silent> ]w :tabnext<CR>
nnoremap <silent> [W :tabfirst<CR>
nnoremap <silent> ]W :tablast<CR>

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

" Esc clears last search
nnoremap <silent> <ESC> :nohlsearch<CR>

" Remap U Redo
nnoremap U <C-r>

" Make i_CTRL-u and w undoable, C-u also kills whole line
inoremap <C-u> <C-g>u<C-u><C-o>"_D
inoremap <C-w> <C-g>u<C-w>

" Quick replace with s
xnoremap s :s/

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(LiveEasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(LiveEasyAlign)

" Easymotion on gs
map gs <Plug>(easymotion-prefix)
nmap gs<Space> <Plug>(easymotion-overwin-w)
xmap gs<Space> gsw
omap gs<Space> gsw
let g:EasyMotion_keys='arsdheiqwfpgjlu;yzxcvbkmtno'

" Set ga to gA (ga is vim-align, gA is print ascii)
nnoremap gA ga

" }}}

" Keybindings Leader {{{

func s:NotDefined(type) abort
	return '{' . a:type . '} is not defined for [' . &filetype . ']'
endfunc

" The following functions should be overwritten in ftplugin if necessary.
func CodeFormat() abort
	call my#format#trim()
	call my#format#reindent()
endfunc

func CodeCompile() abort
	echo s:NotDefined('compiler')
endfunc

func CodeRun() abort
	echo s:NotDefined('run')
endfunc

func CodeTest() abort
	echo s:NotDefined('test')
endfunc

func s:LeaderD() abort
	if winnr('$') == 1
		Sexplore
	else
		Explore
	endif
endfunc

" Use Space & \ as Leader
nmap <SPACE> <Leader>

" Leader Keybindings
nmap <silent> <Leader>b          :Buffers<CR>
nmap <silent> <Leader>c          :call CodeCompile()<CR>
nmap <silent> <Leader>cc         :call CodeCompile()<CR>
nmap <silent> <Leader>cr         :call CodeRun()<CR>
" u -> Unit test
nmap <silent> <Leader>cu         :call CodeTest()<CR>
" d -> Directory
nmap <silent> <Leader>d          :call <SID>LeaderD()<CR>
" f -> Format
nmap <silent> <Leader>f          :call CodeFormat()<CR>
" Fugitive/Git
nmap <silent> <Leader>gb         :GSwitch<CR>
nmap <silent> <Leader>gB         :GSwitchAll<CR>
nmap <silent> <Leader>gc         :Gcommit<CR>
nmap <silent> <Leader>gd         :Gvdiffsplit!<CR>
nmap <silent> <Leader>gf         :Gfetch<CR>
nmap <silent> <Leader>gF         :Gpull<CR>
nmap <silent> <expr> <Leader>gg ':Git '
" h -> Hunk
nmap <silent> <Leader>ghd        :SignifyHunkDiff<CR>
nmap <silent> <Leader>ghu        :SignifyHunkUndo<CR>
nmap <silent> <Leader>glf        :0Glog<CR>
nmap <silent> <Leader>gll        :Glog<CR>
nmap <silent> <Leader>gm         :Gmerge<CR>
nmap <silent> <Leader>gp         :Gpush<CR>
nmap <silent> <Leader>gr         :Grebase<CR>
nmap <silent> <Leader>gs         :Gstatus<CR>
" w -> Who did this?
nmap <silent> <Leader>gw         :Gblame<CR>
nmap <silent> <Leader>j          gs<Space>
nmap <silent> <Leader>l          <Plug>window:quickfix:loop
" o -> Outline
nmap <silent> <Leader>o          :TagbarToggle<CR>
nmap <silent> <Leader>s          :call my#keybinds#Spell()<CR>
nmap <silent> <Leader>t          :Tags<CR>
" TODO Replace with GFiles if in git
nmap <silent> <Leader><SPACE>    :Files<CR>
nmap <silent> <Leader>/          :Lines<CR>
nmap <silent> <expr> <Leader>?  ':Rg '

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
