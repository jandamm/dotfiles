-- Helper to add mappings from elsewhere which does not error when whichkey
-- isn't installed

-- NOTE: Using buffer = 0 might not work when the mapping is created before VimEnter

local M = {
	buffer = {},
}

-- Check global mappings for conflicts
local map = {}
local function flatten(prefix, mappings)
	local flattened = {}
	for key, value in pairs(mappings) do
		if type(value) == 'string' or value[1] then
			if key ~= 'name' then
				flattened[prefix .. key] = true
			end
		else
			flattened = vim.tbl_extend('keep', flattened, flatten(prefix .. key, value))
		end
	end
	return flattened
end
local function check(table, opts)
	local mode = opts and opts.mode or 'n'
	if not map[mode] then
		map[mode] = table
		return
	end
	local ok, new_map = pcall(vim.tbl_extend, 'error', map[mode], table)
	if not ok then
		vim.notify('There are duplicates in the mappings. See :messages', 'Error')
		for key, _ in pairs(table) do
			print('Possible conflict for this mapping: ' .. key .. 'in mode: ' .. mode)
		end
	else
		map[mode] = new_map
	end
end

local installed, whichkey = pcall(require, 'which-key')
local register = installed and whichkey.register or function() end

if not installed then
	vim.notify('Which-Key is not installed. Some mappings might be missing.', 'Error')
end

function M.map(key, mapping, name, opts)
	check({ [key] = true }, opts)
	return register({ [key] = { mapping, name } }, opts)
end
function M.buffer.map(key, mapping, name, opts)
	return register({ [key] = { mapping, name, buffer = vim.api.nvim_get_current_buf() } }, opts)
end

function M.name(key, name, opts)
	return register({ [key] = name }, opts)
end
function M.buffer.name(key, name, opts)
	return register({ [key] = { name, buffer = vim.api.nvim_get_current_buf() } }, opts)
end

function M.register(mapping, opts)
	check(flatten(opts and opts.prefix or '', mapping), opts)
	return register(mapping, opts)
end
function M.buffer.register(mapping, opts)
	opts = opts or {}
	opts.buffer = vim.api.nvim_get_current_buf()
	return register(mapping, opts)
end

return M
