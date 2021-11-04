--- Unload and require a module
function _G.reload(module)
	require'plenary.reload'.reload_module(module, true)
	return require(module)
end

function _G.prequire(module)
	local ok, mod = pcall(require, module)
	return ok and mod
end
