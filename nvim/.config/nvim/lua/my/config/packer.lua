vim.cmd [[autocmd my_config BufWritePost */lua/my/packer.lua,*/lua/my/config/*.lua lua reload 'my.packer'; vim.cmd 'PackerCompile']]

if not vim.g.my_packer then
	vim.g.my_packer = true

	-- Packer command shims
	-- 			-- Create most used commands to get completion for them
	vim.cmd [[
		command! -nargs=* PackerCompile lua require 'my.packer'; vim.cmd('PackerCompile '..<q-args>)
		command! -nargs=* PackerInstall lua require 'my.packer'; vim.cmd('PackerInstall '..<q-args>)
		command! -nargs=* PackerSync    lua require 'my.packer'; vim.cmd('PackerSync '..<q-args>)
		autocmd my_config CmdUndefined Packer* ++once lua require'my.packer'
	]]
end
