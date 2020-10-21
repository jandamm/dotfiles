scriptencoding utf-8

if exists('g:loaded_diagnostics')
	finish
endif
let g:loaded_diagnostics = 1

let g:lsp_diagnostics_enabled = 0
let g:lsc_enable_autocomplete = v:false
let g:lsc_enable_diagnostics  = v:false

let g:lsc_auto_map = {
    \ 'GoToDefinition': 'gd',
    \ 'GoToDefinitionSplit': '<C-w>gd',
    \ 'FindReferences': 'gr',
    \ 'Rename': 'gR',
    \ 'ShowHover': v:true,
    \ 'Completion': 'omnifunc',
    \}

augroup my_diagnostics
	au!
	" Refresh Quickfixsigns
	autocmd QuickFixCmdPost * QuickfixsignsEnable

	" Stop asyncdo when leaving vim. Otherwise vim might print to stdout.
	autocmd VimLeavePre * AsyncStop
	autocmd VimLeavePre * LAsyncStop
augroup END

" LSP Server Config {{{

if !exists('g:lsc_server_commands') | let g:lsc_server_commands = {} | endif

let g:lsc_server_commands['ios.swift'] = { 'command': ['neovim', 'swift', 'lsp', 'ios'], 'languageId': 'swift'}
let g:lsc_server_commands.swift = ['neovim', 'swift', 'lsp']
let g:lsc_server_commands.sh = ['bash-language-server', 'start']
let g:lsc_server_commands.vim = ['vim-language-server', '--stdio']

" }}}

" Quickfix Signs {{{

let g:signify_priority = 6
"                                  10        8          8          7       4
let g:quickfixsigns_classes = ['vcsmerge', 'loc', 'breakpoints', 'qfl', 'marks']
let g:quickfixsigns_list_types = 'EWIewi'

function! s:define(char, text, hl) abort
	execute 'sign define QFS_LOC_'.toupper(a:char).' text='.a:text.' texthl='.a:hl
	execute 'sign define QFS_LOC_'.tolower(a:char).' text='.a:text.' texthl='.a:hl
	execute 'sign define QFS_QFL_'.toupper(a:char).' text='.a:text.' texthl='.a:hl
	execute 'sign define QFS_QFL_'.tolower(a:char).' text='.a:text.' texthl='.a:hl
endfunction

call s:define('E', '✖', 'QfSignE')
call s:define('W', '‼', 'QfSignW')
call s:define('I', 'i', 'QfSignI')
sign define QFS_LOC text=» texthl=QfSign
sign define QFS_QFL text=» texthl=QfSign

" }}}

" vim-qf don't open qf automatically. (Incompatible with vim-dispatch)
let g:qf_auto_open_loclist = 0
let g:qf_auto_open_quickfix = 0
let g:qf_mapping_ack_style = 1
