local luasnip = require 'luasnip'
local snip = luasnip.snippet
local node = luasnip.snippet_node
local text = luasnip.text_node
local insert = luasnip.insert_node
local func = luasnip.function_node
local choice = luasnip.choice_node
local dynamic = luasnip.dynamic_node
local helper = require 'my.snippets.helper'

--- Insert matching pair and place trigger inside
local function snip_pair(start, stop)
	return snip(start, { text(start), insert(0, ''), text(stop or start) })
end

--- Shared between plug and use
local function plugin()
	return {
		text { '{', "\t'" },
		insert(1, 'repo'),
		text { "',", '' },
		choice(2, {
			node(nil, { text "\tcmd = { '", insert(1, 'Cmd'), text { "' },", '' } }),
			text '',
		}),
		choice(3, {
			node(nil, { text "\trequires = { '", insert(1, 'repo'), text { "' },", '' } }),
			text '',
		}),
		choice(4, {
			node(nil, { text { '\tsetup = function()', '\t\t' }, insert(1), text { '', '\tend,', '' } }),
			text '',
		}),
		choice(5, {
			node(nil, { text { '\tconfig = function()', '\t\t' }, insert(1), text { '', '\tend,', '' } }),
			node(nil, { text "\tconfig = [[reload 'my.config.", insert(1, 'plugin'), text { "']],", '' } }),
			text '',
		}),
		text '}',
	}
end

luasnip.snippets = {
	all = {
		snip('{', { text { '{', '\t' }, insert(0, ''), text { '', '}' } }),
		snip_pair('(', ')'),
		snip_pair('[', ']'),
		snip_pair '"',
		snip_pair "'",
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
		snip('use', { text 'use ', node(1, plugin()) }),
		snip('plug', { node(1, plugin()), text ',' }),
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
