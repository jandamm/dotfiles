require'my.map'.buffer.map('<Leader>cx', '<CMD>Xclean<CR>', 'Clean')
require'my.map'.buffer.map('<Leader>fx', '<CMD>Xopen %<CR>', 'Open in Xcode')

if not vim.g.loaded_ios_ftplugin then
	vim.g.loaded_ios_ftplugin = true

	require'my.map'.map('<Leader>ox', '<CMD>Xopen<CR>', 'Xcode')
end
