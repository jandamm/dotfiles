command! -buffer -nargs=* SwiftFormat call my#ft#swift#swiftformat('<args>')
setlocal formatprg=neovim\ swiftformat\ %\ --fragment\ true
nmap <buffer> <Leader>cb <CMD>call my#ft#swift#build()<CR>
let g:lmap.c.b = 'Build with spm'

" Add nicer version keeping correct indentation
command! -range -buffer MultilineFormat
			\ <line1>,<line2>substitute/\v%(\(\zs *\ze[^)]|\[\zs *\ze[^]]|,\zs *\ze.|[^(]\zs *\ze\)|[^[]\zs *\ze\])/\r/g <BAR>
			\ nohlsearch

compiler swiftpm
if filereadable('Makefile')
	set makeprg=make
endif

augroup swift_linter
	autocmd! * <buffer>
	autocmd BufWritePost <buffer> Lmake! swiftlint
augroup END

" if exists('g:loaded_swift_ftplugin')
" 	finish
" endif
" let g:loaded_swift_ftplugin = 1
