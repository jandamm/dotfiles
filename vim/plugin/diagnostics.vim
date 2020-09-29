scriptencoding utf-8

if exists('g:loaded_diagnostics')
	finish
endif
let g:loaded_diagnostics = 1

let g:lsp_diagnostics_enabled = 0

function! s:MakeLspSettings() abort
	if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif

	nmap <buffer> gd <Plug>(lsp-definition)
	nmap <buffer> gr <Plug>(lsp-references)
	nmap <buffer> gi <Plug>(lsp-implementation)
	nmap <buffer> gt <Plug>(lsp-type-definition)
	nmap <buffer> [g <Plug>(lsp-previous-diagnostic)
	nmap <buffer> ]g <Plug>(lsp-next-diagnostic)
	if &filetype !=? 'vim'
		nmap <buffer> K  <Plug>(lsp-hover)
	endif

	" Not sure how to integrate yet
	" nmap <buffer> <leader>rn <plug>(lsp-rename)
endfunction

augroup my_diagnostics
	au!
	autocmd Filetype * ++once call neomake#configure#automake('rnw', 500)
	autocmd User lsp_buffer_enabled call s:MakeLspSettings()
	autocmd User lsp_setup ++once call s:RegisterLsp()
augroup END

" LSP Server Config {{{

function! s:RegisterLsp(...) abort
	call lsp#register_server({
				\ 'name': 'sourcekit-lsp-ios',
				\ 'cmd': {server_info->['neovim-swift', 'lsp', 'ios'] + my#ft#swift#compiler_flags() },
				\ 'allowlist': ['ios', 'ios.swift'],
				\ 'languageId': {server_info->'swift'},
				\ })
	call lsp#register_server({
				\ 'name': 'sourcekit-lsp',
				\ 'cmd': {server_info->['neovim-swift', 'lsp'] + my#ft#swift#compiler_flags() },
				\ 'allowlist': ['swift'],
				\ })
	call lsp#register_server({
				\ 'name': 'bash-language-server',
				\ 'cmd': {server_info->[&shell, &shellcmdflag, 'bash-language-server start']},
				\ 'allowlist': ['sh'],
				\ })
	call lsp#register_server({
				\ 'name': 'vim-language-server',
				\ 'cmd': {server_info->['vim-language-server', '--stdio']},
				\ 'allowlist': ['vim'],
				\ })
endfunction

" }}}

" Quickfix Signs {{{

" Enable 'loc' when neomake is disabled
let g:quickfixsigns_classes = ['qfl', 'marks', 'vcsmerge', 'breakpoints']
let g:quickfixsigns_list_types = 'EWIewi'

function! s:define(char, text, hl) abort
	" execute 'sign define QFS_LOC_'.toupper(a:char).' text='.a:text.' texthl='.a:hl
	" execute 'sign define QFS_LOC_'.tolower(a:char).' text='.a:text.' texthl='.a:hl
	execute 'sign define QFS_QFL_'.toupper(a:char).' text='.a:text.' texthl='.a:hl
	execute 'sign define QFS_QFL_'.tolower(a:char).' text='.a:text.' texthl='.a:hl
endfunction

call s:define('E', '✖', 'QfSignE')
call s:define('W', '‼', 'QfSignW')
call s:define('I', 'i', 'QfSignI')
sign define QFS_QFL text=» texthl=QfSign

" }}}

" vim-qf don't open qf automatically. (Incompatible with vim-dispatch)
let g:qf_auto_open_loclist = 0
let g:qf_auto_open_quickfix = 0
let g:qf_mapping_ack_style = 1

let g:neomake_info_sign = {
			\ 'text': 'i',
			\ 'texthl': 'NeomakeInfoSign'
			\ }
let g:neomake_message_sign = g:neomake_info_sign
