if exists('g:loaded_swift_ftplugin')
	finish
endif
let g:loaded_swift_ftplugin = 1

command! -nargs=* SwiftFormat call my#ft#swift#format('<args>')

" Leader Mapping {{{

function! CodeFormat() abort
	call my#ft#swift#format('%')
endfunction

function! CodeCompile() abort
	call my#ft#swift#build()
endfunction
function! CodeRun() abort
	call my#ft#swift#run()
endfunction
function! CodeTest() abort
	call my#ft#swift#test()
endfunction

" }}}

" LSP {{{

augroup swift_lsp_setup
	au!
	autocmd BufEnter *.swift call asyncomplete#enable_for_buffer()
	" autocmd User lsp_setup echom 'here'
augroup END
call lsp#register_server({
			\ 'name': 'sourcekit-lsp',
			\ 'cmd': {server_info->['lsp-swift']},
			\ 'whitelist': ['swift'],
			\ })

" }}}

" Neomake {{{

function! s:RunNeomake(...) abort
	Neomake! swiftpm
endfunction

let s:makers = neomake#makers#ft#swift#EnabledMakers()
if string(s:makers) =~# 'swiftpm'
	let g:neomake_swift_enabled_makers = ['swiftlint']
	augroup neomake_swift_group
		au!
		autocmd BufWritePost *.swift call s:RunNeomake()
		autocmd BufWinEnter *.swift call timer_start(500, function('s:RunNeomake'))
	augroup END
else
	" Until my PR is accepted
	let g:neomake_swift_enabled_makers = add(s:makers, 'swiftlint')
endif

" Swiftlint maker
function! s:MySwiftLint() abort
	" Until my PR is accepted
	" let maker = neomake#makers#ft#swift#swiftlint()
	let maker = { 'exe': 'neomake-swiftlint', 'append_file': 1, 'errorformat': '%f:%l:%c: %trror: %m,%f:%l:%c: %tarning: %m,%f:%l: %trror: %m,%f:%l: %tarning: %m' }
	let maker.exe = 'neomake-swiftlint'
	let maker.args = []
	return maker
endfunction

function! s:MySwiftPM() abort
	return {
				\ 'exe': 'neomake-swiftbuild',
				\ 'append_file': 0,
				\ 'errorformat':
				\ '%E%f:%l:%c: error: %m,' .
				\ '%E%f:%l: error: %m,' .
				\ '%E%f: error: %m,' .
				\ '%W%f:%l:%c: warning: %m,' .
				\ '%Z%\s%#^~%#,' .
				\ '%-G%.%#',
				\ }
endfunction

" single file maker
function! s:MySwiftC() abort
	let maker = neomake#makers#ft#swift#swiftpm()
	let maker.append_file = 1
	let maker.args = []
	return maker
endfunction

let g:neomake_swift_swiftlint_maker = s:MySwiftLint()
let g:neomake_swift_swiftpm_maker = s:MySwiftPM()
let g:neomake_swift_swiftc_maker = s:MySwiftC()

" }}}
