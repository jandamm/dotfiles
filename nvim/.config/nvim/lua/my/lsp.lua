local M = {}
local all_attaches = {}

---Register a callback which is called when attached to a lsp (except null_ls)
---@param on_attach function
function M.register_on_attach(on_attach)
	table.insert(all_attaches, on_attach)
end

function M.on_attach(client)
	for _, on_attach in ipairs(all_attaches) do
		on_attach(client)
	end
end

return M
