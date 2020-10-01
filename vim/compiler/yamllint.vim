if exists('current_compiler')
	finish
endif
let current_compiler = 'yamllint'

CompilerSet makeprg=yamllint\ -f\ parsable\ %

CompilerSet errorformat=
			\%E%f:%l:%c:\ [error]\ %m,
			\%W%f:%l:%c:\ [warning]\ %m
