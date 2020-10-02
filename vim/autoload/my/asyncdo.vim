if exists('g:autoloaded_my_asyncdo')
	finish
endif
let g:autoloaded_my_asyncdo = 1

function! my#asyncdo#run(type, nojump, cmd, ...) abort
	let args = a:0 ? a:1 : ''
	if a:type ==# 'l'
		call asyncdo#lrun(a:nojump, a:cmd, args)
	elseif a:type ==# 'c'
		call asyncdo#run(a:nojump, a:cmd, args)
	else
		echoerr 'Unknown type for asyncdo run: '.a:type
	endif
endfunction

function! my#asyncdo#stop(type) abort
	if a:type ==# 'l'
		call asyncdo#lstop()
	elseif a:type ==# 'c'
		call asyncdo#stop()
	else
		echoerr 'Unknown type for asyncdo stop: '.a:type
	endif
endfunction

function! my#asyncdo#openListIf(bool, type) abort
	if a:bool
		call my#asyncdo#openList(a:type)
	endif
endfunction

function! my#asyncdo#openList(type) abort
	call my#asyncdo#onDone(a:type, a:type.'window')
endfunction

function! my#asyncdo#onDone(type, command) abort
	if a:type ==# 'l'
		execute 'autocmd QuickFixCmdPost l* ++once '.a:command
	elseif a:type ==# 'c'
		execute 'autocmd QuickFixCmdPost [^l]* ++once '.a:command
	else
		echoerr 'Unknown type for asyncdo list: '.a:type
	endif
endfunction
