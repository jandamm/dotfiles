if exists('current_compiler')
	finish
endif
let current_compiler = 'swiftsh'

CompilerSet makeprg=swift\ sh\ %

CompilerSet errorformat=
			\%E%f:%l:%c:\ error:\ %m,
			\%E%f:%l:\ error:\ %m,
			\%E%f:\ error:\ %m,
			\%W%f:%l:%c:\ warning:\ %m,
			\%Z%\s%#^~%#,
			\%Eerror:\ %m,
			\%-G%.%#
