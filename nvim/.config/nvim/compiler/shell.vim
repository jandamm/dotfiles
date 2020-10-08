if exists('current_compiler')
	finish
endif
let current_compiler = 'shell'

let shebang = matchstr(getline(1), '^#!\s*\zs.*$')
if !empty(shebang)
	let cmd = split(shebang)
	execute 'CompilerSet makeprg='.cmd[0].'\ '.join(cmd[1:], '\ ').'\ -n\ %'
elseif getbufvar(bufnr('%'), '&filetype') ==# 'zsh'
	CompilerSet makeprg=/usr/bin/env\ zsh\ -n\ %
else
	CompilerSet makeprg=/usr/bin/env\ sh\ -n\ %
endif

CompilerSet errorformat=
			\%E%f:\ line\ %l:\ %m,
			\%E%f:\ %l:\ %m,
			\%E%f:%l:\ %m
