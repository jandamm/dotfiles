if exists('current_compiler')
	finish
endif
let current_compiler = 'swiftlint'

CompilerSet makeprg=neovim\ swiftlint\ %

CompilerSet errorformat=
			\%f:%l:%c:\ %trror:\ %m,
			\%f:%l:%c:\ %tarning:\ %m,
			\%f:%l:\ %trror:\ %m,
			\%f:%l:\ %tarning:\ %m
