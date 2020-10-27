command! -buffer -nargs=* SwiftFormat call my#ft#swift#swiftformat('<args>')
setlocal formatprg=neovim\ swiftformat\ %\ --fragment\ true
nmap <buffer> <Leader>cb <CMD>call my#ft#swift#build()<CR>
let g:lmap.c.b = 'Build with spm'

" Add nicer version keeping correct indentation
command! -range -buffer MultilineFormat
			\ <line1>,<line2>substitute/\v%(\(\zs *\ze[^)]|\{\zs *\ze[^}]|\[\zs *\ze[^]]|,\zs *\ze.|[^(]\zs *\ze\)|[^{]\zs *\ze\}|[^[]\zs *\ze\]|<in>\zs ?\ze)/\r/g <BAR>
			\ nohlsearch

compiler swiftpm
if filereadable('Makefile')
	set makeprg=make
endif

call my#lint#setup('swiftlint')

" if exists('g:loaded_swift_ftplugin')
" 	finish
" endif
" let g:loaded_swift_ftplugin = 1
