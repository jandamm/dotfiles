if exists('current_compiler')
	finish
endif
let current_compiler = 'gitlabci'

CompilerSet makeprg=gitlab-ci-lint\ %

" Everything is an error
CompilerSet errorformat=%E%m
