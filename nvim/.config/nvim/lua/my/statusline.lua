local M = {}

local gitstatus = require 'my.gitstatus'
function M.git(context)
	local status = gitstatus.get(context)
	local head = (status.detached and status.tag and '@' .. status.tag)
		or (status.detached and status.head and '#' .. string.sub(status.head, 1, 8))
		or status.head
	return head and ' ' .. head or ''
end

return M
