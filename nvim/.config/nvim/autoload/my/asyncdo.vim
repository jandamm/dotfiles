if exists('g:autoloaded_my_asyncdo')
	finish
endif
let g:autoloaded_my_asyncdo = 1

func! s:finalize(scope, prefix, settitle) abort
	let l:job = get(a:scope, 'asyncdo')
	if type(l:job) isnot v:t_dict | return | endif
	try
		let l:tmp = &errorformat
		if has_key(l:job, 'errorformat')
			let &errorformat = l:job.errorformat
		endif
		exe a:prefix.(l:job.jump ? '' : 'get').'file '.l:job.file
		call a:settitle(has_key(l:job, 'title') ? l:job.title : l:job.cmd, l:job.nr)
	finally
		let &errorformat = l:tmp
		unlet! a:scope.asyncdo
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

func! s:build(scope, prefix, settitle) abort
	function! Run(nojump, cmd, ...) abort closure
		if type(get(a:scope, 'asyncdo')) == v:t_dict
			echoerr 'There is currently running job, just wait' | return
		endif

		if type(a:cmd) == type({})
			let l:job = deepcopy(a:cmd)
			let l:cmd = a:cmd.job
		else
			let l:job = {}
			let l:cmd = a:cmd
		endif

		call extend(l:job, {'nr': win_getid(), 'file': tempname(), 'jump': !a:nojump})
		let l:args = copy(a:000)
		if l:cmd =~# '\$\*'
			let l:job.cmd = substitute(l:cmd, '\$\*', join(l:args), 'g')
		else
			let l:job.cmd = join([s:escape(l:cmd)] + l:args)
		endif
		echom l:job.cmd
		let l:spec = [&shell, &shellcmdflag, l:job.cmd . printf(&shellredir, l:job.file)]
		let l:Cb = {-> s:finalize(a:scope, a:prefix, a:settitle)}
		if !has_key(l:job, 'errorformat')
			let l:job.errorformat = &errorformat
		endif

		if has('nvim')
			let l:job.id = jobstart(l:spec, {'on_exit': l:Cb})
		else
			let l:job.id = job_start(l:spec, {
						\   'in_io': 'null','out_io': 'null','err_io': 'null',
						\   'exit_cb': l:Cb
						\ })
		endif
		let a:scope['asyncdo'] = l:job
	endfunc

	func! Stop() abort closure
		let l:job = get(a:scope, 'asyncdo')
		if type(l:job) is v:t_dict
			if has('nvim')
				call jobstop(l:job.id)
			else
				call job_stop(l:job.id)
			endif
			unlet! a:scope['asyncdo']
		endif
	endfunc

	return { 'run': funcref('Run'), 'stop': funcref('Stop') }
endfunc

let s:qf = s:build(g:, 'c', {title, nr -> setqflist([], 'a', {'title': title})})
let s:ll = s:build(w:, 'l', {title, nr -> setloclist(nr, [], 'a', {'title': title})})

func! my#asyncdo#crun(...) abort
	call call(s:qf.run, a:000)
endfunc
func! my#asyncdo#cstop(...) abort
	call call(s:qf.stop, a:000)
endfunc
func! my#asyncdo#lrun(...) abort
	call call(s:ll.run, a:000)
endfunc
func! my#asyncdo#lstop(...) abort
	call call(s:ll.stop, a:000)
endfunc

function! my#asyncdo#run(type, nojump, cmd, ...) abort
	let args = a:0 ? a:1 : ''
	if my#asyncdo#running(a:type)
		echoerr 'Asyncdo is already running for: '.a:type
	elseif a:type ==# 'l'
		call my#asyncdo#lrun(a:nojump, a:cmd, args)
	elseif a:type ==# 'c'
		call my#asyncdo#crun(a:nojump, a:cmd, args)
	else
		echoerr 'Unknown type for asyncdo run: '.a:type
	endif
endfunction

function! my#asyncdo#running(type, ...) abort
	if a:type ==# 'l'
		" There is a bug which results in asyncdo running local builds only in the
		" first window. It still may not work when the first window is removed and
		" asyncdo is started from another window. This also prevents multiple jobs
		" to run in parallel (one per window).
		" When this is fixed, the following line should work.
		" return getwinvar(winnr, 'asyncdo', {}) != {}
		let winnr = a:0 ? a:1 : winnr()
		let asyncdo = getwinvar(1, 'asyncdo', {})
		return has_key(asyncdo, 'nr') && asyncdo.nr == win_getid(winnr)
	elseif a:type ==# 'c'
		return exists('g:asyncdo')
	endif
endfunction

function! my#asyncdo#stop(type) abort
	if a:type ==# 'l'
		call my#asyncdo#lstop()
	elseif a:type ==# 'c'
		call my#asyncdo#cstop()
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
