nmap <silent> <buffer> <leader>ck <CMD>Xclean<CR>
let g:lmap.c.k = 'Clean'

nmap <silent> <buffer> <Leader>fx  <CMD>Xopen %<CR>
let g:lmap.f.x = 'Open in Xcode'

if exists('g:loaded_ios_ftplugin')
	finish
endif
let g:loaded_ios_ftplugin = 1

nmap <silent> <Leader>ox  <CMD>Xopen<CR>
let g:lmap.o.x = 'Xcode'

" Xcode {{{

let g:xcode_default_simulator = 'iPhone 11 Pro'
let g:xcode_runner_command = 'Dispatch {cmd}'
let g:xcode_disable_xcpretty = 1

let g:xcode_additional_xcargs = '-quiet 2>/dev/null'
let g:xcode_additional_xcargs_test = '2>/dev/null | xcpretty --no-utf --color'

" }}}
