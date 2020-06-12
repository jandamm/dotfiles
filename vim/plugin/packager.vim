if exists('g:loaded_packager')
	finish
endif
let g:loaded_packager = 1

command! PackagerInstall runtime plugins.vim | call packager#install()
command! -bang PackagerUpdate runtime plugins.vim | call packager#update({ 'force_hooks': '<bang>' })
command! PackagerClean runtime plugins.vim | call packager#clean()
command! PackagerStatus runtime plugins.vim | call packager#status()
