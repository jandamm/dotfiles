" Vim compiler file

scriptencoding utf-8

if exists('current_compiler')
	finish
endif
let current_compiler = 'git'

let s:cpo_save = &cpoptions
set cpoptions-=C

if exists('g:fugitive_git_executable')
	execute 'CompilerSet makeprg='.escape(g:fugitive_git_executable, ' "\')
else
	CompilerSet makeprg=git
endif

CompilerSet errorformat=
			\%-G%.%#%\\r%.%\\+,
			\Cloning\ into%.%#\ '%f'...,
			\%+Egit:\ %m,
			\%+Eerror:\ %m,
			\%+Wwarning:\ %m,
			\%+Iusage\ %#:\ %m,
			\%+Efatal\ %#:\ %m,
			\%+ECannot\ %.%#:\ You\ have\ unstaged\ changes.,
			\%+ECannot\ %.%#:\ Your\ index\ contains\ uncommitted\ changes.,
			\%+EThere\ is\ no\ tracking\ information\ for\ the\ current\ branch.,
			\%+EYou\ are\ not\ currently\ on\ a\ branch.\ Please\ specify\ which,
			\CONFLICT\ (%m):\ %f\ deleted\ in\ %.%#,
			\CONFLICT\ (%m):\ Merge\ conflict\ in\ %f,
			\CONFLICT\ (%m):\ Rename\ \"%f\"->%.%#,
			\CONFLICT\ (%m):\ Rename\ %.%#->%f\ %.%#,
			\CONFLICT\ (%m):\ There\ is\ a\ directory\ with\ name\ %f\ in\ %.%#,
			\%+ECONFLICT\ %.%#,
			\%\\w%\\t%f

let &cpoptions = s:cpo_save
unlet s:cpo_save
