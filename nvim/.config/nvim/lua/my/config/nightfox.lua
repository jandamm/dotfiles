local fox = 'nordfox'

local function status(color, style)
	return { fg = color, style = style, bg = 'bg0' }
end

require('nightfox').setup {
	options = {
		terminal_colors = true, -- Configure the colors used when opening :terminal
		styles = {
			comments = 'italic', -- Style that is applied to comments: see `highlight-args` for options
			functions = 'NONE', -- Style that is applied to functions: see `highlight-args` for options
			keywords = 'NONE', -- Style that is applied to keywords: see `highlight-args` for options
			strings = 'NONE', -- Style that is applied to strings: see `highlight-args` for options
			variables = 'NONE', -- Style that is applied to variables: see `highlight-args` for options
		},
	},
	groups = { -- Override highlight groups
		all = {
			User1 = status('palette.cyan', 'bold'),
			User2 = status 'palette.yellow',
			User3 = status 'palette.blue.dim',
			User8 = status('palette.comment', 'bold'),
			User9 = status 'palette.black.bright',
			DiagnosticStatusE = status 'palette.red',
			DiagnosticStatusW = status 'palette.yellow',
			DiagnosticStatusI = status 'palette.blue',
		},
	},
}

vim.cmd [[
	colorscheme nordfox
	hi! link DiagnosticHint            DiagnosticInfo
	hi! link DiagnosticFloatingHint    DiagnosticFloatingInfo
	hi! link DiagnosticSignHint        DiagnosticSignInfo
	hi! link DiagnosticUnderlineHint   DiagnosticUnderlineInfo
	hi! link DiagnosticVirtualTextHint DiagnosticVirtualTextInfo
]]
