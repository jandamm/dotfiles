local M = {}

-- local cache = {}
local function git_dir(context)
	local ok, status = pcall(vim.api.nvim_buf_get_var, context.bufnr, 'gitsigns_status_dict')
	-- TODO: Also parse fugitives b:git_dir
	-- TODO: Add own fallback
	return ok and status
end

function M.get(context)
	local dir = git_dir(context)
	if not dir then return {} end
	-- TODO: Parse from git_dir/HEAD instead of using gitsigns-head
	-- TODO: Include tag if head is detached
	-- TODO: Cache values
	return {
		head = dir.head or vim.g.gitsigns_head
	}
end

return M
