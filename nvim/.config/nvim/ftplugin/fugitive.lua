require('my.map').buffer.register({
	po = { ':GG pr open ', 'New PR for current Branch', noremap = true },
	pp = { '.GG pr new ', 'New PR' },
	ps = { '.GG pr switch ', 'Switch to PR branch' },
	pu = { '.GG pr update ', 'Update PR' },
}, { noremap = false, silent = false })

-- Overwrite fugitives p with which key
vim.cmd [[autocmd User FugitiveChanged ++once nmap <buffer> p <Cmd>lua require("which-key").show("p", {mode = "n", auto = true})<CR>]]
