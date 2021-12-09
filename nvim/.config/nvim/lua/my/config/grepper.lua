vim.g.grepper = {
	tools = { 'git', 'ack', 'rg', 'vimgrep' },
	highlight = true,
	vimgrep = {
		grepprg = [[nvim -es +'set nonu nornu | vimgrep /$*/ ** | cw | %p | qa']],
		grepprgbuf = [[nvim -es +'set nonu nornu | vimgrep /$*/ $. | cw | %p | qa']],
		grepformat = [[%f|%l col %c|%m]],
	},
}

vim.cmd [[
	nmap <silent> g/ <Plug>(GrepperOperator)
	xmap <silent> g/ <Plug>(GrepperOperator)
]]
