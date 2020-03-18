if exists('g:loaded_ios_ftplugin')
	finish
endif
let g:loaded_ios_ftplugin = 1

" Xcode {{{

let g:xcode_default_simulator = 'iPhone 11 Pro'
let g:xcode_runner_command = 'VtrSendCommandToRunner! {cmd}'

" }}}

" Leader Mapping {{{

nnoremap <Leader>c :call my#ft#ios#build()<CR>
nnoremap <Leader>r :call my#ft#ios#run()<CR>
nnoremap <Leader>u :call my#ft#ios#test()<CR>

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
