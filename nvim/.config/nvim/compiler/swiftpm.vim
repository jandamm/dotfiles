if exists('current_compiler')
	finish
endif
let current_compiler = 'swiftpm'

let file = filereadable('Package.swift') ? '' : '\ %'
execute 'CompilerSet makeprg=neovim\ swift'.file

CompilerSet errorformat=
			\%E%f:%l:%c:\ error:\ %m,
			\%E%f:%l:\ error:\ %m,
			\%E%f:\ error:\ %m,
			\%Eerror:\ %m,
			\%W%f:%l:%c:\ warning:\ %m,
			\%Z%\s%#^~%#,
			\%-G%.%#
