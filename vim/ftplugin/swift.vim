command! -nargs=* -buffer SwiftFormat call my#ft#swift#format('<args>')

" Leader Mapping {{{

nnoremap <silent> <Leader>f :SwiftFormat %<CR>

" }}}

" Neomake {{{

let s:makers = neomake#makers#ft#swift#EnabledMakers()
	" Until my PR is accepted
	let g:neomake_swift_enabled_makers = add(s:makers, 'swiftlint')

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
