" Runs a linter when a file is opened and saved
function! my#lint#enable(compiler, ...) abort
	call s:setup(a:compiler, !(a:0 && a:1), 0)
endfunction

" Runs a linter when a file is opened, saved and when the buffer is switched.
function! my#lint#enableAutoLint(compiler, ...) abort
	call s:setup(a:compiler, !(a:0 && a:1), 1)
endfunction

function! my#lint#disable(compiler) abort
	let linters = s:linters()
	let index = index(linters, a:compiler)
	if index == -1 | return | endif
	call s:disable(a:compiler)
	call remove(linters, index)
	call s:set_linters(linters)
endfunction

function! my#lint#disableAll() abort
	for linter in s:linters()
		call s:disable(linter)
	endfor
	call s:set_linters([])
endfunction

" MARK: Private api
function! s:disable(compiler) abort
	exe printf('autocmd! %s * <buffer=%d>', s:group(a:compiler), bufnr())
endfunction

function! s:setup(compiler, bang, auto) abort
	let bufnr = bufnr()
	call timer_start(500, {-> s:init(a:bang, a:compiler, bufnr, a:auto) })
	call s:add_linter(a:compiler)
endfunction

function! s:init(bang, compiler, bufnr, auto) abort
	call s:lint(a:bang, a:bufnr, a:compiler)
	let group = s:group(a:compiler)
	exe printf('augroup %s | augroup END', group)
	exe printf('autocmd! %s * <buffer=%d>', group, a:bufnr)
	call s:autocmd('BufWritePost', a:bang, a:compiler, a:bufnr, 0)
	if a:auto
		" Automatically update when changing Buffer, focussing.
		call s:autocmd('BufWinEnter,FocusGained', a:bang, a:compiler, a:bufnr, 1)
	endif
endfunction

function! s:autocmd(event, bang, compiler, bufnr, auto) abort
	exe printf('au %s %s <buffer=%d> call <SID>lint(%d,%d,"%s",%d)', s:group(a:compiler), a:event, a:bufnr, a:bang, a:bufnr, a:compiler, a:auto)
endfunction

function! s:group(compiler) abort
	return 'my_lint_'.a:compiler
endfunction

function! s:lint(bang, bufnr, compiler, ...) abort
	if a:0 && a:1 && get(g:, 'disable_auto_lint', 0) | return | endif
	let winid = bufwinid(a:bufnr)
	if winid <= 0 | return | endif
	call my#command#lmake(a:bang, winid, a:compiler)
endfunction

" Get/Set linters
function! s:linters() abort
	return getbufvar('%', 'enabled_linter', [])
endfunction

function! s:add_linter(linter) abort
	let linters = s:linters()
	call insert(linters, a:linter)
	call s:set_linters(linters)
endfunction

function! s:set_linters(linters) abort
	return setbufvar('%', 'enabled_linter', a:linters)
endfunction
