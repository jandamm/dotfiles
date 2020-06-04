scriptencoding utf-8

if exists('g:loaded_statusline_plugin')
	finish
endif
let g:loaded_statusline_plugin = 1

hi! link User1 OneStatusLineHue2

function! MySleuth() abort
	let ret = SleuthIndicator()
	return ret ==? 'ts=2' ? '' : ' [' . ret . ']'
endfunction
function! Spell() abort
	return &spell ? ' [' . toupper(strcharpart(&spelllang, 0, 2)) . ']' : ''
endfunction
function! GitBranch() abort
	let branch = fugitive#head()
	return len(branch) > 0 ? ' ' . branch : ''
endfunction
function NeomakeStatusline()
	let stats = []
	let lcounts = neomake#statusline#LoclistCounts()
	if len(lcounts) > 0
		call add(stats, 'F[')
	endif
	for key in sort(keys(lcounts))
		call add(stats, printf('%s:%d', key, lcounts[key]))
	endfor
	if len(lcounts) > 0
		call add(stats, ']')
	endif
	let qcounts = neomake#statusline#QflistCounts()
	if len(qcounts) > 0
		call add(stats, 'P[')
	endif
	for key in sort(keys(qcounts))
		call add(stats, printf('%s:%d', key, qcounts[key]))
	endfor
	if len(qcounts) > 0
		call add(stats, ']')
	endif
	return join(stats, ' ')
endfunction

function! Get(active, winnr) abort
	let filetype = getbufvar(winbufnr(a:winnr), '&filetype')
	if filetype ==? 'qf'
		return '%1*<%f%*%=%P-%l-%c'
	endif
	let line=''                            " Define
	if a:active
		let line.='%1*'                      " Color 1
	endif
	let line.='ν'                          " Symbol
	let line.=' %<%f'                      " filename (shorten if line is too long)
	let line.='%*'                         " Default color
	let line.=' (%n)'                      " Buffer number
	let line.=GitBranch()                  " Git branch
	if filetype !=# ''
		let line.=' %y'                      " filetype with [ft]
	endif
	if a:active
		let line.=Spell()                    " Spelling
		let line.=MySleuth()                 " Show current Spaces/Tabs settings (Maybe only if not ts=2)
	endif
	let line.='%4m'                        " modified ' [+]' (always 4 chars)
	let line.='%5r'                        " readonly with ' [RO]' (always 5 chars)
	let line.='%='                         " right align from here
	if a:active
		let line.=NeomakeStatusline()        " Quick hack for Neomake Errors/Warnings
	endif
	let line.='  %P'                       " viewport of buffer (Top / % / Bot)
	let line.='-%l'                        " current line
	let line.='-%c'                        " current column
	return line
endfunction

function! Setup() abort
	let window = winnr()
	for i in range(1, winnr('$'))
		let active = window == i
		call setwinvar(i, '&statusline', '%!Get('. active .','.i.')')
	endfor
endfunction

augroup my_statusline
	autocmd!
	autocmd WinEnter,BufEnter,BufDelete,SessionLoadPost,FileChangedShellPost * call Setup()
	autocmd FileType qf call Setup()
augroup END
