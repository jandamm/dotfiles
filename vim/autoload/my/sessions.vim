if exists('g:autoloaded_my_session')
	finish
endif
let g:autoloaded_my_session = 1

let s:sessions_dir = expand('~/.vim/session/')

" Create a session for the current dir
function! my#sessions#make() abort
	if exists('g:this_obsession')
		call s:error('Already in obsession.', 'WarningMsg')
		return
	endif
	let session = s:cur_session_file()
	if filereadable(session)
		call s:error('Session file already exists.')
		return
	endif
	execute 'Obsession '.fnameescape(session)
endfunction

" Session file or session for current dir
function! my#sessions#load(...) abort
	let session = a:0 ? s:session_file(a:1) : s:cur_session_file()
	if exists('g:this_obsession') && g:this_obsession ==# session
		call s:error('Already in this obsession.', 'Normal')
	elseif filereadable(session)
		call my#sessions#end()
		execute 'silent source '.fnameescape(session)
	else
		call s:error('No session exists.')
	endif
endfunction

" Stop session and quit all buffers
function! my#sessions#end() abort
	wall
	if exists('g:this_obsession')
		silent Obsession
	endif
	silent! tabonly
	silent! only
	silent! %bwipe!
endfunction

" Delete the current or given session
function! my#sessions#delete(...) abort
	let session = a:0 ? s:session_file(a:1) : s:cur_session_file()
	if exists('g:this_obsession') && g:this_obsession ==# session
		silent Obsession!
	elseif filereadable(session)
		call system('rm '.session)
	else
		call s:error('No session file found.')
	endif
endfunction

" List all session files
function! my#sessions#list() abort
	return map(systemlist('ls '.s:sessions_dir), { _, val -> s:unescape(val) })
endfunction

function! s:cur_session_file() abort
	return s:session_file(getcwd().'.vim')
endfunction

function! s:session_file(path) abort
	return s:sessions_dir . s:escape(substitute(a:path, '^'.s:sessions_dir, '' ,''))
endfunction

function! s:escape(path) abort
	return substitute(a:path, '/', '%', 'g')
endfunction

function! s:unescape(path) abort
	return substitute(a:path, '%', '/', 'g')
endfunction

function! s:error(message, ...) abort
	let hi = a:0 ? a:1 : 'Error'
	execute 'echohl '.hi
	echo a:message
	echohl Normal
endfunction
