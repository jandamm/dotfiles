" Xcode {{{

let g:xcode_default_simulator = 'iPhone 11 Pro'
let g:xcode_runner_command = 'VtrSendCommandToRunner! {cmd}'

" }}}

" Leader Mapping {{{

nnoremap <Leader>c :Xbuild<CR>
nnoremap <Leader>r :Xrun<CR>
nnoremap <Leader>u :Xtest<CR>

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
