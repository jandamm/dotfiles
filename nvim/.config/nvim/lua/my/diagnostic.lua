local M = {}

function M.on()
	vim.b.disable_diagnostic = false
	vim.diagnostic.enable(0)
end

function M.off()
	vim.b.disable_diagnostic = true
	vim.diagnostic.disable(0)
end

function M.toggle()
	if vim.b.disable_diagnostic then
		M.on()
	else
		M.off()
	end
end

---@param insert boolean Is entering insert mode
function M.auto(insert)
	if vim.b.disable_diagnostic then return end
	if insert then
		vim.diagnostic.hide(nil, 0)
	else
		vim.diagnostic.show(nil, 0)
	end
end

return M
