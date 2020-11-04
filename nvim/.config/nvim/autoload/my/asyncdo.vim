if exists('g:autoloaded_my_asyncdo')
	finish
endif
let g:autoloaded_my_asyncdo = 1

func! s:finalize(prefix, settitle, winid, exitCode) abort
	let l:job = s:get(a:prefix, a:winid)
	if type(l:job) isnot v:t_dict | return | endif
	try
		let l:tmp = &errorformat
		if has_key(l:job, 'errorformat')
			let &errorformat = l:job.errorformat
		endif
		if filereadable(l:job.file)
			let isCurwin = a:prefix ==# 'c' || s:winid() == a:winid
			if !isCurwin && l:job.jump
				let isCurwin = win_gotoid(a:winid)
			endif
			if isCurwin
				exe a:prefix.(l:job.jump ? '' : 'get').'file '.l:job.file
			else
				call setloclist(a:winid, [], ' ', { 'lines': readfile(l:job.file) })
			endif
			call a:settitle(has_key(l:job, 'title') ? l:job.title : l:job.cmd, a:winid)
		elseif a:exitCode != 0
			call s:echoerr('Job did fail: '.a:exitCode)
		else
			call s:echoerr('No file, no fail')
		endif
	finally
		let &errorformat = l:tmp
		call s:del(a:prefix, a:winid)
		call delete(l:job.file)
	endtry
endfunc

" expand filename-modifiers explicitly
func! s:fnameexpand(str) abort
	return substitute(a:str, '\v\\=%(\%|\#)%(\:[phrte])*', {a->expand(a[0])}, 'g')
endfunc

" prepare backslashes for shell consumption via job logic in s:build
func! s:slashescape(str) abort
	return substitute(a:str, '\\', '\\\\\\', 'g')
endfunc

func! s:escape(str) abort
	return s:slashescape(s:fnameexpand(a:str))
endfunc

function! s:echoerr(message) abort
	echohl Error | echom a:message | echohl Normal
endfunction

func! s:get(prefix, winid) abort
	" try
		if a:prefix ==# 'l'
			silent! return nvim_win_get_var(a:winid, 'asyncdo')
		else
			silent! return nvim_get_var('asyncdo')
		endif
	" catch | return | endtry
endfunc

func! s:set(prefix, winid, value) abort
	if a:prefix ==# 'l'
		call nvim_win_set_var(a:winid, 'asyncdo', a:value)
	else
		call nvim_set_var('asyncdo', a:value)
	endif
endfunc

func! s:del(prefix, winid) abort
	if a:prefix ==# 'l'
		silent! call nvim_win_del_var(a:winid, 'asyncdo')
	else
		silent! call nvim_del_var('asyncdo')
	endif
endfunc

func! s:build(prefix, settitle) abort
	function! Run(winid, nojump, cmd, ...) abort closure
		if s:running(a:prefix, a:winid)
			call s:echoerr('There is currently running job, just wait') | return
		endif

		if type(a:cmd) == type({})
			let l:job = deepcopy(a:cmd)
			let l:cmd = a:cmd.job
		else
			let l:job = {}
			let l:cmd = a:cmd
		endif

		call extend(l:job, {'file': tempname(), 'jump': !a:nojump})
		let l:args = copy(a:000)
		if l:cmd =~# '\$\*'
			let l:job.cmd = substitute(l:cmd, '\$\*', join(l:args), 'g')
		else
			let l:job.cmd = join([s:escape(l:cmd)] + l:args)
		endif
		let l:spec = [&shell, &shellcmdflag, l:job.cmd . printf(&shellredir, l:job.file)]
		let l:Cb = { id, code, type -> s:finalize(a:prefix, a:settitle, a:winid, code)}
		if !has_key(l:job, 'errorformat')
			let l:job.errorformat = &errorformat
		endif

		let l:job.id = jobstart(l:spec, {'on_exit': l:Cb})
		call s:set(a:prefix, a:winid, l:job)
	endfunc

	func! Stop(winid) abort closure
		let l:job = s:get(a:prefix, a:winid)
		if type(l:job) is v:t_dict
			call jobstop(l:job.id)
			call s:del(a:prefix, a:winid)
		endif
	endfunc

	return { 'run': funcref('Run'), 'stop': funcref('Stop') }
endfunc

function! s:running(prefix, winid) abort
	return type(s:get(a:prefix, a:winid)) == v:t_dict
endfunction

function! s:run(prefix, winid, args) abort
	let args = [a:winid] + a:args
	if a:prefix ==# 'l'
		call call(s:ll.run, args)
	else
		call call(s:qf.run, args)
	endif
endfunction

function! s:stop(prefix, winid) abort
	if a:prefix ==# 'l'
		call call(s:ll.stop, [a:winid])
	else
		call call(s:qf.stop, [a:winid])
	endif
endfunction

function! s:winid(...) abort
	if !a:0 || a:1 <= 0
		return win_getid()
	elseif a:1 < 1000
		return win_getid(a:1)
	else
		return a:1
	endif
endfunction

let s:qf = s:build('c', {title, nr -> setqflist([], 'a', {'title': title})})
let s:ll = s:build('l', {title, nr -> setloclist(nr, [], 'a', {'title': title})})

function! my#asyncdo#run(prefix, winid, ...) abort
	call s:run(a:prefix, s:winid(a:winid), a:000)
endfunction

function! my#asyncdo#stop(prefix, ...) abort
	call s:stop(a:prefix, s:winid(a:0 ? a:1 : 0))
endfunction

function! my#asyncdo#stopAndRun(prefix, winid, ...) abort
	let winid = s:winid(a:winid)
	if s:running(a:prefix, winid)
		" After stopping a run, a timeout is needed. Otherwise the old job
		" finishes the new job. calling the callback with the new data.
		call s:stop(a:prefix, winid)
		let args = a:000
		call timer_start(250, {-> s:run(a:prefix, winid, args) })
	else
		call s:run(a:prefix, winid, a:000)
	endif
endfunction

function! my#asyncdo#running(prefix, ...) abort
	return s:running(a:prefix, s:winid(a:0 ? a:1 : 0))
endfunction

function! my#asyncdo#openListIf(bool, prefix) abort
	if a:bool
		call my#asyncdo#openList(a:prefix)
	endif
endfunction

function! my#asyncdo#openList(prefix) abort
	call my#asyncdo#onDone(a:prefix, a:prefix.'window')
endfunction

function! my#asyncdo#onDone(prefix, command) abort
	if a:prefix ==# 'l'
		execute 'autocmd QuickFixCmdPost l* ++once '.a:command
	else
		execute 'autocmd QuickFixCmdPost [^l]* ++once '.a:command
	endif
endfunction
