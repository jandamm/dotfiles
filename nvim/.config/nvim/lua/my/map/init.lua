-- Helper to add mappings from elsewhere which does not error when whichkey
-- isn't installed

local installed, whichkey = pcall(require, 'which-key')
if not installed then
	vim.notify('Which-Key is not installed. Some mappings might be missing.', 'Error')
end

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
	table = flatten(opts.prefix or '', table)
	local mode = opts.mode
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
local function copy(table, last)
	return last and table or vim.deepcopy(table)
end

local function register(mappings, buffer, modes, opts)
	if not installed then
		return
	end

	opts = opts or {}
	modes = type(modes) == 'string' and { modes } or modes or { 'n' }

	local n = #modes
	for i, mode in ipairs(modes) do
		opts.mode = mode
		if buffer then
			-- NOTE: Using buffer = 0 might not work when the mapping is created before VimEnter
			opts.buffer = vim.api.nvim_get_current_buf()
		else
			check(mappings, opts)
		end
		local last = i == n
		whichkey.register(copy(mappings, last), copy(opts, last))
	end
end

local M = { buffer = {} }

---Define one mapping
---@param key string Trigger
---@param mapping string Execution
---@param name string WhichKey Label
---@param modes string|table Default is { 'n' }
---@param opts table WhichKey Opts
function M.map(key, mapping, name, modes, opts)
	register({ [key] = { mapping, name } }, false, modes, opts)
end
---Define one mapping for the active buffer
---@param key string Trigger
---@param mapping string Execution
---@param name string WhichKey Label
---@param modes string|table Default is { 'n' }
---@param opts table WhichKey Opts
function M.buffer.map(key, mapping, name, modes, opts)
	register({ [key] = { mapping, name } }, true, modes, opts)
end

---Name one mapping
---@param key string Trigger
---@param name string WhichKey Label
---@param modes string|table Default is { 'n' }
---@param opts table WhichKey Opts
function M.name(key, name, modes, opts)
	register({ [key] = name }, false, modes, opts)
end
---Name one mapping for the active buffer
---@param key string Trigger
---@param name string WhichKey Label
---@param modes string|table Default is { 'n' }
---@param opts table WhichKey Opts
function M.buffer.name(key, name, modes, opts)
	register({ [key] = name }, true, modes, opts)
end

---Wrapper around whichkey
---@param reg table WhichKey mapping table
---@param modes string|table Default is { 'n' }
---@param opts table WhichKey Opts
function M.register(reg, modes, opts)
	register(reg, false, modes, opts)
end
---Wrapper around whichkey for the active buffer
---@param reg table WhichKey mapping table
---@param modes string|table Default is { 'n' }
---@param opts table WhichKey Opts
function M.buffer.register(reg, modes, opts)
	register(reg, true, modes, opts)
end

return M
