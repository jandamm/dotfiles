---Unload a module
---@param module string
function _G.unload(module)
	require('plenary.reload').reload_module(module, true)
end

---Unload and require a module
---@param module string
---@return string
function _G.reload(module)
	unload(module)
	return require(module)
end

---Inspect and log the object
---@param object any
function _G.put(object)
	print(vim.inspect(object))
end
