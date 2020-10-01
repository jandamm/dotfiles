if exists('current_compiler')
	finish
endif
let current_compiler = 'shellcheck'

CompilerSet makeprg=shellcheck\ -fgcc\ -x\ %

CompilerSet errorformat=
			\%f:%l:%c:\ %trror:\ %m\ [SC%n],
			\%f:%l:%c:\ %tarning:\ %m\ [SC%n],
			\%I%f:%l:%c:\ Note:\ %m\ [SC%n]
