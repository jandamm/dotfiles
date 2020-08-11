if exists('g:loaded_ios_ftplugin')
	finish
endif
let g:loaded_ios_ftplugin = 1

" Xcode {{{

let g:xcode_default_simulator = 'iPhone 11 Pro'
let g:xcode_runner_command = 'Dispatch {cmd}'
let g:xcode_xcpretty_flags = '--no-utf --color'

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
