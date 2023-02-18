command! -buffer -range=% SwiftFormat call my#ft#swift#swiftformat(<line1>,<line2>)
setlocal formatprg=neovim\ swiftformat\ %\ --fragment\ true

lua require'my.map'.buffer.map('<Leader>cb', '<CMD>call my#ft#swift#build()<CR>', 'Build with spm')

" Add nicer version keeping correct indentation
command! -range -buffer MultilineFormat
			\ <line1>,<line2>substitute/\v%(\(\zs *\ze[^)]|\{\zs *\ze[^}]|\[\zs *\ze[^]]|,\zs *\ze.|[^(]\zs *\ze\)|[^{]\zs *\ze\}|[^[]\zs *\ze\]|<in>\zs ?\ze)/\r/g <BAR>
			\ nohlsearch

if filereadable('Makefile')
	let b:uses_make=1
endif

let b:textobj_function_select = function('textobj#function#swift#select')
