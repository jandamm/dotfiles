local luasnip = require 'luasnip'
local snip = luasnip.snippet
local node = luasnip.snippet_node
local text = luasnip.text_node
local insert = luasnip.insert_node
local func = luasnip.function_node
local choice = luasnip.choice_node
local dynamic = luasnip.dynamic_node

local M = {
	env = {},
}

---Use VISUAL (not selected) or insert node with placeholder
---@param jump number
---@param placeholder? string
function M.vis_or_insert(jump, placeholder)
	return dynamic(jump, function(_, snippet)
		local vis = snippet.env.TM_SELECTED_TEXT[1]
		if vis then
			return node(nil, { text(vis), insert(1) })
		else
			return node(nil, { insert(1, placeholder or '') })
		end
	end, {})
end

---Use insert node with VISUAL or placeholder
---@param jump number
---@param placeholder? string
function M.insert_vis(jump, placeholder)
	return dynamic(jump, function(_, snippet, _)
		return node(nil, insert(1, snippet.env.TM_SELECTED_TEXT[1] or placeholder or ''))
	end, {})
end

---Insert jump position again
---@param jump number
function M.copy(jump)
	return func(function(args)
		return args[1]
	end, jump)
end

---Get content before the cursor
---@param snippet table Snippet provided by luasnip
---@return string
function M.env.before(snippet)
	return snippet.env.TM_CURRENT_LINE:match('^(.*)' .. snippet.trigger, 1)
end

vim.schedule(function() unload 'my.snippets.helper' end)
return M
