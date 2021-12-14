require('which-key').setup {
	plugins = {
		spelling = { enabled = true },
	},
	window = {
		border = 'single',
		margin = { 0, 0, 0, 0 },
		padding = { 1, 0, 1, 0 },
	},
	operators = { gc = 'Comments' },
	key_labels = {
		['<leader>'] = '⎵',
		['<space>'] = '⎵',
		['<CR>'] = '',
		['<Tab>'] = '',
		['<BS>'] = '',
	},
}

-- require('which-key').register({
-- 	z = 'lightspeed',
-- }, { mode = 'o' })

reload 'my.config.whichkey.leader'
