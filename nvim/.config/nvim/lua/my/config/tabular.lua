-- TODO: migrate to lua
vim.cmd [[
	nmap ga :Tabularize<SPACE>/
	xmap ga :Tabularize<SPACE>/

	nmap gav :Tabularize<SPACE>/\V
	xmap gav :Tabularize<SPACE>/\V

	for shortcut in [':', '=', ',', '.']
		execute 'nmap ga'.shortcut.' <CMD>Tabularize /\V'.shortcut.'<CR>'
		execute 'xmap ga'.shortcut.' :Tabularize /\V'.shortcut.'<CR>'
	endfor

	" Set ga to gA (ga is Tabularize, gA is print ascii)
	nnoremap gA ga
]]
