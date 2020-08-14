if exists('current_compiler')
    finish
endif
let current_compiler = 'swiftpm'

CompilerSet makeprg=neovim\ swift

CompilerSet errorformat=
				\%E%f:%l:%c:\ error:\ %m,
				\%E%f:%l:\ error:\ %m,
				\%E%f:\ error:\ %m,
				\%W%f:%l:%c:\ warning:\ %m,
				\%Z%\s%#^~%#,
				\%-G%.%#
