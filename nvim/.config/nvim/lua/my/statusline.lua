local M = {}

local gitstatus = require 'my.gitstatus'
function M.git(context)
	local status = gitstatus.get(context)
	local head = status.head or status.tag or (status.commit and string.sub(status.commit, 1, 8))
	return head and ' ' .. head or ''
end

return M
