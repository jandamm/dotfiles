--- Unload and require a module
function _G.reload(module)
	package.loaded[module] = nil
	return require(module)
end
