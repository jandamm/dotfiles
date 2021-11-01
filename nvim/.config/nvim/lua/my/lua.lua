--- Unload and require a module
function _G.reload(module)
	package.loaded[module] = nil
	return require(module)
end

function _G.prequire(module)
	local ok, mod = pcall(require, module)
	return ok and mod
end
