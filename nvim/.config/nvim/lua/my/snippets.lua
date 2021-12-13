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
		snip('func', {
			dynamic(1, function(_, snippet)
				local line = helper.env.before(snippet)
				if line == '' then
					return node(nil, choice(1, { text 'local ', text '' }))
				elseif line:match '^%s*$' then
					return node(nil, choice(1, { text '', text 'local ' }))
				end
				return node(nil, text '')
			end, {}),
			text 'function',
			dynamic(2, function(args, snippet)
				local line = helper.env.before(snippet)
				local is_local = line:match '^%s*local%s*$'
				if not is_local and not line:match '^%s*$' then
					return node(nil, text '')
				elseif not is_local and args[1][1] ~= 'local ' then
					return node(nil, { choice(1, { text ' M.', text ' ' }), insert(2, 'name') })
				end
				return node(nil, { text ' ', insert(1, 'name') })
			end, { 1 }),
			text '(',
			insert(3, 'param'),
			text { ')', '\t' },
			helper.vis_or_insert(4),
			text { '', 'end' },
		}),
	},
}

require('luasnip/loaders/from_vscode').lazy_load { paths = { './vsnip/default' } }
require('luasnip/loaders/from_vscode').lazy_load { paths = { './vsnip/private' } }
