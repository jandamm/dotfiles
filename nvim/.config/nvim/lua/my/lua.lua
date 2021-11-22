--- Unload a module
---@param module string
function _G.unload(module)
	require('plenary.reload').reload_module(module, true)
end

--- Unload and require a module
---@param module string
---@return string
function _G.reload(module)
	unload(module)
	return require(module)
end

--- Load an module if it is available
---@param module string
---@return string
function _G.prequire(module)
	local ok, mod = pcall(require, module)
	return ok and mod
end
