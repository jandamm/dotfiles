local fox = 'nordfox'

local function status(color, style)
	return { fg = color, style = style, bg = '${bg_statusline}' }
end

require('nightfox').setup {
	fox = fox, -- Which fox style should be applied
	terminal_colors = true, -- Configure the colors used when opening :terminal
	styles = {
		comments = 'italic', -- Style that is applied to comments: see `highlight-args` for options
		functions = 'NONE', -- Style that is applied to functions: see `highlight-args` for options
		keywords = 'NONE', -- Style that is applied to keywords: see `highlight-args` for options
		strings = 'NONE', -- Style that is applied to strings: see `highlight-args` for options
		variables = 'NONE', -- Style that is applied to variables: see `highlight-args` for options
	},
	hlgroups = { -- Override highlight groups
		User1 = status('${cyan}', 'bold'),
		User2 = status '${yellow}',
		User3 = status '${blue_dm}',
		User8 = status('${comment}', 'bold'),
		User9 = status '${black_br}',
		DiagnosticStatusE = status '${error}',
		DiagnosticStatusW = status '${warning}',
		DiagnosticStatusI = status '${info}',
	},
}

require('nightfox').load()

vim.cmd [[
	hi! link DiagnosticHint            DiagnosticInfo
	hi! link DiagnosticFloatingHint    DiagnosticFloatingInfo
	hi! link DiagnosticSignHint        DiagnosticSignInfo
	hi! link DiagnosticUnderlineHint   DiagnosticUnderlineInfo
	hi! link DiagnosticVirtualTextHint DiagnosticVirtualTextInfo
]]
