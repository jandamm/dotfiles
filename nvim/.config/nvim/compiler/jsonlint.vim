if exists('current_compiler')
	finish
endif
let current_compiler = 'jsonlint'

CompilerSet makeprg=jsonlint\ --compact\ %

CompilerSet errorformat=
			\%ELine\ %l:%c,
			\%Z\\s%#Reason:\ %m,
			\%C%.%#,
			\%E%f:\ line\ %l\\,\ col\ %c\\,\ %m,
			\%-G%.%#
