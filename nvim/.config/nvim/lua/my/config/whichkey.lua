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
		['<leader>'] = ' ',
		['<space>'] = ' ',
		['<CR>'] = ' ',
		['<Tab>'] = ' ',
		['<BS>'] = ' ',
		-- ['<BS>'] = ' ',
	},
}

vim.cmd [[highlight! link WhichKeyFloat FloatBorder]]

-- require('which-key').register({
-- 	z = 'lightspeed',
-- }, { mode = 'o' })
-- require('which-key').register {
-- 	g = { c = { name = 'wow', c = 'hey' } }
-- }

reload 'my.config.whichkey.leader'
