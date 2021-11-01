local luasnip = require 'luasnip'
local snip = luasnip.snippet
local node = luasnip.snippet_node
local text = luasnip.text_node
local insert = luasnip.insert_node
local func = luasnip.function_node
local choice = luasnip.choice_node
local dynamic = luasnip.dynamic_node
local helper = require 'my.snippets.helper'

luasnip.snippets = {
	all = {
		snip('test this', {
			text 'some test',
			insert(1, ' place'),
			text { ' end', 'new' },
			helper.copy(1),
			choice(2, { text 'ad', text 'bd' }),
		}),
	},
	lua = {
		snip('put', {
			text 'print(vim.inspect(',
			helper.vis_or_insert(1),
			text '))',
		}),
		-- A snippet wich checks the current line for `local`
		-- Could be used for function snippet to decide if local should be added or not.
		snip('ss', {
			dynamic(1, function(_, _, _)
				local line = string.sub(vim.api.nvim_get_current_line(), 0, vim.api.nvim_win_get_cursor(0)[2])
				if line == 'local ' then
					return node(nil, text 'hiho')
				end
				return node(nil, text(line))
			end, {}),
		}),
	},
}

require('luasnip/loaders/from_vscode').lazy_load { paths = { './vsnip/default' } }
require('luasnip/loaders/from_vscode').lazy_load { paths = { './vsnip/private' } }
