-- Helper to add mappings from elsewhere which does not error when whichkey
-- isn't installed

-- NOTE: Using buffer = 0 might not work when the mapping is created before VimEnter

local M = {
	buffer = {},
}

local whichkey = prequire 'which-key'

if not whichkey then
	vim.notify 'Which-Key is not installed. Some mappings might be missing.'
end

function M.map(key, mapping, name, opts)
	return whichkey and whichkey.register({ [key] = { mapping, name } }, opts)
end

function M.buffer.map(key, mapping, name, opts)
	return whichkey and whichkey.register({ [key] = { mapping, name, buffer = vim.api.nvim_get_current_buf() } }, opts)
end

function M.name(key, name, opts)
	return whichkey and whichkey.register({ [key] = name }, opts)
end

function M.buffer.name(key, name, opts)
	return whichkey and whichkey.register({ [key] = { name, buffer = vim.api.nvim_get_current_buf() } }, opts)
end

M.register = whichkey and whichkey.register or function() end
function M.buffer.register(mapping, opts)
	local o = opts or {}
	o.buffer = vim.api.nvim_get_current_buf()
	return whichkey and whichkey.register(mapping, o)
end

return M
