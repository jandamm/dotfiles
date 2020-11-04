if exists('g:autoloaded_my_lint')
	finish
endif
let g:autoloaded_my_lint = 1

augroup my_lint
augroup END

" Runs a linter when a file is opened and saved
function! my#lint#setup(compiler, ...) abort
	call s:setup(a:compiler, !(a:0 && a:1), 0)
endfunction

" Runs a linter when a file is opened, saved and when the buffer is switched.
function! my#lint#auto(compiler, ...) abort
	call s:setup(a:compiler, !(a:0 && a:1), 1)
endfunction

function! s:setup(compiler, bang, auto) abort
	let bufnr = bufnr()
	call timer_start(500, {-> s:init(a:bang, a:compiler, bufnr, a:auto) })
endfunction

function! s:init(bang, compiler, bufnr, auto) abort
	call s:lint(a:bang, a:bufnr, a:compiler)
	exe 'autocmd! my_lint * <buffer='.a:bufnr.'>'
	call s:autocmd('BufWritePost', a:bang, a:compiler, a:bufnr, 0)
	if a:auto
		" Automatically update when changing Buffer, focussing.
		call s:autocmd('BufWinEnter,FocusGained', a:bang, a:compiler, a:bufnr, 1)
	endif
endfunction

function! s:autocmd(group, bang, compiler, bufnr, auto) abort
	exe 'au my_lint '.a:group.' <buffer='.a:bufnr.'> call <SID>lint('.a:bang.','.a:bufnr.',"'.a:compiler.'",'.a:auto.')'
endfunction

function! s:lint(bang, bufnr, compiler, ...) abort
	if a:0 && a:1 && get(g:, 'disable_auto_lint', 0) | return | endif
	let winid = bufwinid(a:bufnr)
	if winid <= 0 | return | endif
	call my#command#lmake(a:bang, winid, a:compiler)
endfunction
