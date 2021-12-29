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

local function find_override_func(line_nr, lookback)
	line_nr = line_nr - 1
	local lines = vim.api.nvim_buf_get_lines(0, math.max(line_nr - lookback, 0), line_nr, false)
	for i = #lines, 1, -1 do
		local raw = lines[i]
		if raw:find ' func ' then
			return raw:match('override .*func (.*)', 1)
		end
	end
end

local function remove_type_brackets(rest)
	local comma = rest:find(', ', nil, true)
	if not comma then
		return ''
	end
	local bracket = rest:find('(', nil, true)
	return comma < bracket and rest or rest:sub(rest:find(')', nil, true) or 0, -1)
end

local function find_parameter(rest, i)
	local param_end = rest:find(': ', nil, true)
	if not param_end then
		return i, ''
	end
	local param = vim.split(rest:sub(0, param_end - 1), ' ')
	return (i or 0) + 1,
		param[1],
		param[2],
		remove_type_brackets(rest:sub(param_end + 2, -1)):match(', (.*: .*)$', 1) or ''
end

--- Shared between plug and use
local function conf(single)
	local indent = single and '' or '\t'
	return {
		choice(1, {
			node(nil, { text(indent .. "cmd = { '"), insert(1, 'Cmd'), text { "' },", '' } }),
			text '',
		}),
		choice(2, {
			node(nil, { text(indent .. "requires = { '"), insert(1, 'repo'), text { "' },", '' } }),
			text '',
		}),
		choice(3, {
			node(
				nil,
				{ text { indent .. 'setup = function()', indent .. '\t' }, insert(1), text { '', indent .. 'end,', '' } }
			),
			text '',
		}),
	}
end
local function config(single)
	local indent = single and '' or '\t'
	local newline = text(single and '' or { '', '' })
	local nodes = {
		node(
			nil,
			{ text { indent .. 'config = function()', indent .. '\t' }, insert(1), text { '', indent .. 'end,' }, newline }
		),
		node(nil, { text(indent .. "config = [[reload 'my.config."), insert(1, 'plugin'), text "']],", newline }),
	}
	if not single then
		table.insert(nodes, text '')
	end
	return { choice(1, nodes) }
end
local function plugin()
	return {
		text { '{', "\t'" },
		insert(1, 'repo'),
		text { "',", '' },
		choice(2, {
			text '',
			node(nil, conf()),
		}),
		node(3, config()),
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
		snip('conf', conf(true)),
		snip('config', config(true)),
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
	swift = {
		snip('super', {
			text 'super.',
			dynamic(1, function(_, snippet)
				local line = find_override_func(snippet.env.TM_LINE_NUMBER, 7)
				if not line then
					return text ''
				end
				local bracket = line:find('(', nil, true)
				local nodes = { text(line:match('([^(<]*)', 1) .. '(') }
				local i, param, name, rest = find_parameter(line:sub(bracket + 1, -1))
				while param ~= '' do
					name = name or param
					param = param == '_' and '' or param .. ': '
					param = i > 1 and ', ' .. param or param
					table.insert(nodes, text(param))
					table.insert(nodes, insert(i, name))
					i, param, name, rest = find_parameter(rest, i)
				end
				table.insert(nodes, text ')')
				return node(nil, nodes)
			end, {}),
		}),
	},
}

require('luasnip/loaders/from_vscode').lazy_load { paths = { './vsnip/default' } }
require('luasnip/loaders/from_vscode').lazy_load { paths = { './vsnip/private' } }
