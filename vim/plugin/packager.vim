if exists('g:loaded_packager')
	finish
endif
let g:loaded_packager = 1

command! PackagerInstall update <BAR> runtime plugins.vim <BAR> call packager#install()
command! -bang PackagerUpdate update <BAR> runtime plugins.vim <BAR> call packager#update({ 'force_hooks': '<bang>' })
command! PackagerClean update <BAR> runtime plugins.vim <BAR> call packager#clean()
command! PackagerStatus update <BAR> runtime plugins.vim <BAR> call packager#status()
