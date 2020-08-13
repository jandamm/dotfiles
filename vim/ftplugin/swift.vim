command! -buffer -nargs=* SwiftFormat call my#ft#swift#swiftformat('<args>')

if exists('g:loaded_swift_ftplugin')
	finish
endif
let g:loaded_swift_ftplugin = 1

" Neomake {{{

let s:makers = neomake#makers#ft#swift#EnabledMakers()
if string(s:makers) =~# 'swiftpm'
	let g:neomake_swift_enabled_makers = ['swiftlint']
else
	" Until my PR is accepted
	let g:neomake_swift_enabled_makers = add(s:makers, 'swiftlint')
endif

function! s:MySwiftPM() abort
	return {
				\ 'exe': 'neovim-swift',
				\ 'args': ['build'],
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

let g:neomake_swift_swiftlint_maker = {
				\ 'exe': 'neomake-swiftlint',
				\ 'append_file': 1,
				\ 'errorformat': '%f:%l:%c: %trror: %m,' .
				\ '%f:%l:%c: %tarning: %m,' .
				\ '%f:%l: %trror: %m,' .
				\ '%f:%l: %tarning: %m',
				\ }
let g:neomake_swift_swiftpm_maker = s:MySwiftPM()
let g:neomake_swift_swiftc_maker = s:MySwiftC()

" }}}
