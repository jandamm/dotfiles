setlocal foldmethod=marker
setlocal foldmarker={{{,}}}

call my#map#apply#tagInclude(':')

if bufname() =~# '.*/\.xvimrc'
	LSClientDisable
else
	call my#lint#enable('vint')
endif
