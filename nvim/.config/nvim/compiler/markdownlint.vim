if exists('current_compiler')
	finish
endif
let current_compiler = 'markdownlint'

CompilerSet makeprg=markdownlint\ %

CompilerSet errorformat=
			\%W%f:%l:%c\ %m,
			\%W%f:\ %l:\ %c:\ %m,
			\%W%f:%l\ %m,
			\%W%f:\ %l:\ %m
