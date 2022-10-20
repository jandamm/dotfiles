require('my.map').buffer.register({
	po = { ':GG pr open ', 'New PR for current Branch', noremap = true },
	pp = { '.GG pr new --stash ', 'New PR' },
	ps = { '.GG pr switch ', 'Switch to PR branch' },
	pu = { '.GG pr update --stash ', 'Update PR' },
}, 'n', { noremap = false, silent = false })

vim.cmd [[nmap <buffer> p <Cmd>lua require("which-key").show("p", {mode = "n", auto = true})<CR>]]

-- Overwrite fugitives p with which key
-- vim.cmd [[autocmd User FugitiveChanged ++once nmap <buffer> p <Cmd>lua require("which-key").show("p", {mode = "n", auto = true})<CR>]]
