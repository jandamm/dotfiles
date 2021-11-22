local actions = require 'telescope.actions'

require('telescope').setup {
	defaults = {
		layout_config = {
			horizontal = { prompt_position = 'top' },
		},
		sorting_strategy = 'ascending',
		mappings = {
			i = {
				['<C-h>'] = 'which_key',
				['<C-s>'] = 'file_split',
				['<C-f>'] = 'preview_scrolling_down',
				['<C-b>'] = 'preview_scrolling_up',
				['<C-u>'] = function()
					vim.cmd [[normal! "_dd]]
				end,
			},
		},
	},
	pickers = {
		buffers = {
			mappings = {
				i = {
					['<C-x>'] = actions.delete_buffer,
				},
			},
		},
	},
	extensions = {
		frecency = {
			show_unindexed = false,
			ignore_patterns = { '*DerivedData*', '*Assets*', '*.git/*', '*/tmp/*' },
		},
	},
}
