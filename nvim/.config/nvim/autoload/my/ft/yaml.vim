if exists('g:autoloaded_ft_yaml')
	finish
endif
let g:autoloaded_ft_yaml = 1

function! my#ft#yaml#compile() abort
	if bufname('%') =~? '\.gitlab\-ci\.ya\?ml'
		noautocmd silent write
		compiler gitlabci
		Make
	else
		noautocmd silent write
		Lmake! yamllint
	endif
endfunction
