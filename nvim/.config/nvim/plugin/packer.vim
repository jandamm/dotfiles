augroup my_packer
	autocmd!
	autocmd BufWritePost */lua/my/packer.lua,*/lua/my/config/*.lua lua reload 'my.packer'; vim.cmd 'PackerCompile'
augroup END

" Packer command shims
" Create most used commands to get completion for them
command! -nargs=* PackerCompile lua require 'my.packer'; vim.cmd('PackerCompile '..<q-args>)
command! -nargs=* PackerInstall lua require 'my.packer'; vim.cmd('PackerInstall '..<q-args>)
command! -nargs=* PackerSync    lua require 'my.packer'; vim.cmd('PackerSync '..<q-args>)
autocmd my_packer CmdUndefined Packer* ++once lua require'my.packer'
