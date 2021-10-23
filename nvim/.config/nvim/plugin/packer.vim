" You must run this or `PackerSync` whenever you make changes to your plugin configuration
" Regenerate compiled loader file
command! PackerCompile call s:setup() | lua require('my.packer').compile()

" Remove any disabled or unused packer
command! PackerClean call s:setup() | lua require('my.packer').clean()

" Clean, then install missing packer
command! PackerInstall call s:setup() | lua require('my.packer').install()

" Clean, then update and install packer
command! PackerUpdate call s:setup() | lua require('my.packer').update()

" Perform `PackerUpdate` and then `PackerCompile`
command! PackerSync call s:setup() | lua require('my.packer').sync()

function! s:setup() abort
	if bufname() =~# 'my/packer.lua$'
		noautocmd write
	endif
	packadd packer.nvim
	lua package.loaded['my.packer'] = nil
endfunction

augroup packer_auto_compile
	autocmd!
	autocmd BufWritePost packer.lua PackerCompile
augroup END
