" By default `${` and `}` get matched as `PreProc`.
" I want to highlight those delimiters in dark gray - similar to zsh
" highlighting. I don't wnat to set PreProc to dark gray, so I extracted the
" syntax definitions for those groups and replaced the matchgroup with
" shDerefDelim. https://github.com/vim/vim/blob/master/runtime/syntax/sh.vim

syn region shDeref matchgroup=shDerefDelim start="\${" end="}" contains=@shDerefList,shDerefVarArray
if exists('b:is_bash') || exists('b:is_kornshell') || exists('b:is_posix')
	syn region shDeref matchgroup=shDerefDelim start="\${##\=" end="}" contains=@shDerefList nextgroup=@shSpecialNoZS
	syn region shDeref matchgroup=shDerefDelim start="\${\$\$" end="}" contains=@shDerefList nextgroup=@shSpecialNoZS
endif

if exists('b:is_kornshell') || exists('b:is_posix')
	syn region shDeref matchgroup=shDerefDelim start="\${!" end="}" contains=@shDerefVarArray
endif

if exists('b:is_bash')
	syn region shDeref matchgroup=shDerefDelim start="\${!" end="\*\=}" contains=@shDerefList,shDerefOff
endif
