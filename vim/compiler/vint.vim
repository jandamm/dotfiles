if exists('current_compiler')
	finish
endif
let current_compiler = 'vint'

CompilerSet makeprg=vint\ --style-problem\ --no-color\ --enable-neovim\ -f\ '{file_path}:{line_number}:{column_number}:{severity}:{description}\ ({policy_name})'\ %

CompilerSet errorformat=
			\%I%f:%l:%c:style_problem:%m,
			\%f:%l:%c:%t%*[^:]:E%n:\ %m,
			\%f:%l:%c:%t%*[^:]:%m
