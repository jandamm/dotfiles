scriptencoding utf-8

if exists('g:loaded_statusline_plugin')
	finish
endif
let g:loaded_statusline_plugin = 1

" Quick and dirty statusline (needs better colors and refinement)
set statusline=                            " Reset
set statusline+=%1*                        " Color 1
set statusline+=λ                          " Symbol
set statusline+=\ %<%f                     " filename (shorten if line is too long)
set statusline+=%*                         " Default color
set statusline+=\ (%n)                     " Buffer number
set statusline+=%{GitBranch()}             " Git branch
set statusline+=\ %y                       " filetype with [ft]
set statusline+=%{Spell()}                 " Spelling
set statusline+=%{MySleuth()}              " Show current Spaces/Tabs settings (Maybe only if not ts=2)
set statusline+=%4m                        " modified ' [+]' (always 4 chars)
set statusline+=%5r                        " readonly with ' [RO]' (always 5 chars)
" set statusline+=%#IncSearch#%{&paste?'\ \ PASTE\ ':''}%* " show paste mode
set statusline+=%=                         " right align from here
set statusline+=%2*                        " Color 2
set statusline+=\ \ %{NeomakeStatusline()} " Quick hack for Neomake Errors/Warnings
set statusline+=%*                         " Default color
set statusline+=\ \ %P                     " viewport of buffer (Top / % / Bot)
set statusline+=-%l                        " current line
set statusline+=-%c                        " current column

function! MySleuth() abort
	let l:ret = SleuthIndicator()
	return l:ret ==? 'ts=2' ? '' : ' [' . l:ret . ']'
endfunction
function! Spell() abort
	return &spell ? ' [' . toupper(strcharpart(&spelllang, 0, 2)) . ']' : ''
endfunction
function! GitBranch() abort
	let l:branch = fugitive#head()
	return len(l:branch) > 0 ? ' ' . l:branch : ''
endfunction
function NeomakeStatusline()
	let stats = []
	let lcounts = neomake#statusline#LoclistCounts()
	for key in sort(keys(lcounts))
		call add(stats, printf('%s:%d', key, lcounts[key]))
	endfor
	return join(stats, ' ')
endfunction

" function MyStatus(...)
" 	let actual_curbuf = bufnr("%")
" 	return "%c  " .  neomake#statusline#get(actual_curbuf)
" endfunction

" set statusline=%!MyStatus()
