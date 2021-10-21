local light_fts = { 'help', 'man' }
local force = { 'qf', 'help', 'man' }

require('cryoline').config {
	force_ft = force,
	extend_context = function(context)
		context.winnr = vim.api.nvim_win_get_number(context.winid)
	end,
	resolve_ft = function(context)
		local ft = context.ft
		if vim.tbl_contains(light_fts, ft) then
			return 'light_line'
		elseif
			ft == 'fugitive'
			or ft == 'gitcommit'
			or string.match(vim.api.nvim_buf_get_name(context.bufnr), '^fugitive://')
		then
			return 'git'
		elseif string.match(vim.api.nvim_buf_get_name(context.bufnr), '^term://') then
			return 'terminal'
		end
	end,
	ft = {
		dirvish = function(context)
			return vim.fn['my#statusline#dirvish'](context.winnr, context.active)
		end,
		git = function(context)
			return vim.fn['my#statusline#fugitive'](context.winnr, context.active)
		end,
		light_line = function(context)
			return vim.fn['my#statusline#light'](context.winnr, context.active)
		end,
		terminal = function(context)
			return vim.fn['my#statusline#terminal'](context.winnr, context.active)
		end,
		qf = function(context)
			return vim.fn['my#statusline#qf'](context.winnr, context.active)
		end,
	},
	line = function(context)
		return vim.fn['my#statusline#default'](context.winnr, context.active)
	end,
}
