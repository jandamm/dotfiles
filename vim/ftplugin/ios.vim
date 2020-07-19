if exists('g:loaded_ios_ftplugin')
	finish
endif
let g:loaded_ios_ftplugin = 1

" Xcode {{{

let g:xcode_default_simulator = 'iPhone 11 Pro'
let g:xcode_runner_command = 'TermDo {cmd}'

" }}}

" Leader Mapping {{{

function! CodeCompile() abort
	call my#ft#ios#build()
endfunction
function! CodeRun() abort
	call my#ft#ios#run()
endfunction
function! CodeTest() abort
	call my#ft#ios#test()
endfunction

" }}}

" LSP {{{

if executable('lsp-ios')
	augroup ios_lsp_setup
		au!
		autocmd User lsp_setup call lsp#register_server({
					\ 'name': 'sourcekit-lsp',
					\ 'cmd': {server_info->['lsp-ios']},
					\ 'whitelist': ['ios.swift', 'ios'],
					\ })
	augroup END
endif

" }}}

" Neomake {{{

let g:neomake_ios_swiftpm_maker = {
			\ 'exe': 'neomake-swiftbuildios',
			\ 'append_file': 0,
			\ 'errorformat':
			\ '%E%f:%l:%c: error: %m,' .
			\ '%E%f:%l: error: %m,' .
			\ '%E%f: error: %m,' .
			\ '%W%f:%l:%c: warning: %m,' .
			\ '%Z%\s%#^~%#,' .
			\ '%-G%.%#',
			\ }

" }}}
