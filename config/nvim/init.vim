scriptencoding utf-8

" Load plugins (Extracted to file to ease first installation)
runtime plugins.vim

" Allow folder specific tags with .root file
let g:gutentags_project_root=['.root']

" Update signify after x ms
set updatetime=150
" Prefer .root file over .git folder
let g:rooter_patterns = ['.root', 'Rakefile', '.git/']

" Swiftlint maker
let g:neomake_swift_swiftlint_maker = {
			\ 'args': ['lint'],
			\ 'errorformat':
			\ '%E%f:%l:%c: error: %m,' .
			\ '%W%f:%l:%c: warning: %m,' .
			\ '%Z%\s%#^~%#,' .
			\ '%-G%.%#',
			\ }

" single file maker
let g:neomake_swift_swiftpmjd_maker = {
			\ 'exe': 'swift',
			\ 'errorformat':
			\ '%E%f:%l:%c: error: %m,' .
			\ '%E%f:%l: error: %m,' .
			\ '%W%f:%l:%c: warning: %m,' .
			\ '%Z%\s%#^~%#,' .
			\ '%-G%.%#',
			\ }
let g:neomake_swift_enabled_makers = ['swiftpmjd', 'swiftlint']
let g:lsp_diagnostics_enabled = 0

set laststatus=2
" Colorscheme isn't working good
" Use hi User1-9
set statusline=
" set statusline+=%#IncSearch#%{&paste?'\ \ PASTE\ ':''}%*
set statusline+=%1*                    " Color 1
set statusline+=λ                      " Symbol
set statusline+=\ %f                   " filename
set statusline+=%*                     " Default color
set statusline+=\ (%n)                 " Buffer number
set statusline+=\ %y                   " filetype with [ft]
set statusline+=%4m                    " modified ' [+]' (always 4 chars)
set statusline+=%5r                    " readonly with ' [RO]' (always 5 chars)
set statusline+=%=                     " right align from here
set statusline+=%2*                    " Color 2
set statusline+=%{NeomakeStatusline()} " Quick hack for Neomake Errors/Warnings
set statusline+=%*                     " Default color
set statusline+=\ \ %P                 " viewport of buffer (Top / % / Bot)
set statusline+=-%l                    " current line
set statusline+=-%c                    " current column

function NeomakeStatusline()
	let stats = []
	let lcounts = neomake#statusline#LoclistCounts()
	for key in sort(keys(lcounts))
		call add(stats, printf('%s:%d', key, lcounts[key]))
	endfor
	return join(stats, ' ')
endfunction

" function MyStatus(...)
" 	let actual_curbuf = bufnr("%")
" 	return "%c  " .  neomake#statusline#get(actual_curbuf)
" endfunction

" set statusline=%!MyStatus()

" Appearance {{{

" Git Bar always visible
set signcolumn=yes

" Buffer Tabs
let g:buftabline_show=1

if (has('termguicolors'))
	set termguicolors
endif

set background=dark
colorscheme one
let g:one_allow_italics=1
autocmd VimEnter * ++once call one#highlight('gitcommitSummary', 'e5c07b', '', 'none')
autocmd VimEnter * ++once call one#highlight('User1', '61afef', '2c323c', 'none')
autocmd VimEnter * ++once call one#highlight('User2', 'e06c75', '2c323c', 'none')
autocmd VimEnter * ++once call one#highlight('Sneak', 'c678dd', '', 'reverse')
autocmd VimEnter * ++once hi clear StatuslineNC " Quick fix for inactive statusline
highlight link gitcommitOverflow ErrorMsg

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

" Map omnicomplete shortcut to asyncomplete
imap <c-x><c-o> <Plug>(asyncomplete_force_refresh)
function! s:on_lsp_buffer_enabled() abort
	set foldmethod=expr
				\ foldexpr=lsp#ui#vim#folding#foldexpr()
				\ foldtext=lsp#ui#vim#folding#foldtext()
	set nofoldenable
	set completeopt+=menuone

	" refer to doc to add more commands
endfunction

au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#necovim#get_source_options({
    \ 'name': 'necovim',
    \ 'whitelist': ['vim'],
    \ 'completor': function('asyncomplete#sources#necovim#completor'),
    \ }))

augroup lsp_install
	au!
	" call s:on_lsp_buffer_enabled only for languages that has the server registered.
	autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

" Use asyncomplete as omnifunc without auto hud.
" Disable asyncomplete auto popup
let g:asyncomplete_auto_popup = 0
let g:asyncomplete_popup_delay = 0
" Set my own completeopt instead of asyncomplete
let g:asyncomplete_auto_completeopt = 0
set completeopt=menu,preview

" Use c-cr as omnicomplete
imap <c-cr> <c-x><c-o>

" Use tabs for UltiSnips
let g:UltiSnipsExpandTrigger="<NUL>"
let g:UltiSnipsJumpForwardTrigger="<NUL>"
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
let g:UltiSnipsEditSplit='vertical'

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

call neomake#configure#automake('rnw', 500)

" }}}

" Keybindings {{{

map <F13> [
map <C-F13> <C-[>
map <F16> ]
map <C-F16> <C-]>

" Buffer/Tab navigation
nnoremap <c-n> :bn<cr>
nnoremap <c-p> :bp<cr>

" Insert empty line below/above
" modifiable: :lopen and other not modifiable buffers should have the default
" <CR> mapping
nnoremap <expr> <CR>   &modifiable ? ":call keybinds#EnterNewline()\<CR>" : "\<CR>"
nnoremap        <S-CR> :call keybinds#EnterNewlineAbove()<CR>

" Tab for indent otherwise shiftwidth spaces
inoremap <TAB> <C-R>=(keybinds#UltiExpandOrJump() > 0) ? '' : keybinds#SmartTab()<CR>

" Use Enter to comfirm completion
" Enter twice adds newline without comment
let g:endwise_no_mappings=1
inoremap <expr> <CR> keybinds#EnterEnter()

" Correct Y yank behavior
nmap Y y$

" Esc twice to clear last search
nnoremap <ESC><ESC> :nohlsearch<CR>:<BS>

" Remap U Redo
nnoremap U <C-r>

" Use surround.vim with s
xmap s S

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Set ga to gA (ga is vim-align, gA is print ascii)
nnoremap gA ga

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
" Some mappings should be overwritten in ftplugins
" Mainly c, f, r, u
" TODO: Replace l with lopen, select window, lclose
nmap <Leader>b       :Buffers<CR>
nmap <Leader>c       :echo 'No compiler defined'<CR>
nmap <Leader>f       gg=G``zz
nmap <Leader>d       :Sexplore<CR>
nmap <Leader>l       :lopen<CR>
nmap <Leader>r       :echo 'No run target defined'<CR>
nmap <Leader>t       :TagbarToggle<CR>
nmap <Leader>u       :echo 'No test target defined'<CR>
nmap <Leader><Space> :Files<CR>

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

" vim:set foldmethod=marker:
