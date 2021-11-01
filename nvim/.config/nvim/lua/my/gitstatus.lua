local M = {}
local cache = {}

local function get_buf_var(bufnr, name)
	local ok, status = pcall(vim.api.nvim_buf_get_var, bufnr, name)
	return ok and status
end
local function get_gitsigns_dir(bufnr)
	local info = get_buf_var(bufnr, 'gitsigns_status_dict')
	if info and info.gitdir then
		return info.gitdir
	end
end
local function find_git_dir(bufnr, winnr)
	-- TODO: check parent dirs as well
	-- TODO: check for submodules (.git is a file which contains `dir`)
	local dir = vim.fn.getcwd(vim.fn.win_id2win(winnr)) .. '/.git'
	if vim.fn.filereadable(dir .. '/HEAD') == 1 then
		vim.api.nvim_buf_set_var(bufnr, 'git_dir', dir) -- save to fugitive
		return dir
	end
end

local function git_dir(context)
	return get_buf_var(context.bufnr, 'git_dir') -- fugitive
		or get_gitsigns_dir(context.bufnr) -- gitsigns
		or find_git_dir(context.bufnr, context.winnr)
end

local function remove_prefix(input, prefix)
	return vim.fn.match(input, prefix) >= 0 and vim.fn.substitute(input, prefix, '', '')
end

local function get_tag(raw)
	local taglist = io.popen('git name-rev --tags ' .. raw, 'r')
	local tag
	for raw_tag in taglist:lines() do
		tag = remove_prefix(raw_tag, raw .. ' tags/')
		if tag then
			return tag
		end
	end
end

function M.get(context)
	local dir = git_dir(context)
	if not dir then
		return {}
	end
	local file = dir .. '/HEAD'
	local time = vim.fn.getftime(file)
	if time == -1 then
		return {}
	end
	local cached = cache[dir]
	if cached and cached.time == time then
		-- TODO: should I update the tag at some point even when cached?
		return cached.value
	end
	local status = {}
	local raw = vim.fn.readfile(file)[1]
	status.head = remove_prefix(raw, '^ref: refs/heads/')

	if not status.head then
		status.detached = true
		status.head = raw
		status.tag = get_tag(raw)
	end

	cache[dir] = { time = time, value = status }
	return status
end

return M
