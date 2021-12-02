local colors = require 'onenord.colors'
local function status(color, style)
	return { fg = color, style = style, bg = colors.active }
end

require('onenord').setup {
	italics = { comments = true, keywords = false },
	custom_highlights = {
		Statusline = status(colors.fg),
		StatuslineNC = status(colors.light_gray, 'italic'),
		User1 = status(colors.cyan, 'bold'),
		User2 = status(colors.yellow),
		User3 = status(colors.dark_blue),
		User8 = status(colors.light_gray, 'bold'),
		User9 = status(colors.gray),
		DiagnosticStatusE = status(colors.error),
		DiagnosticStatusW = status(colors.warn),
		DiagnosticStatusI = status(colors.info),
		TabLine = { fg = colors.fg, bg = colors.active },
		TabLineSel = { fg = colors.cyan, bg = colors.highlight },
		Whitespace = { fg = colors.selection },
		helpHyperTextJump = { fg = colors.orange },
	},
}

vim.cmd [[
	colorscheme onenord
	hi! link DiagnosticHint            DiagnosticInfo
	hi! link DiagnosticFloatingHint    DiagnosticFloatingInfo
	hi! link DiagnosticSignHint        DiagnosticSignInfo
	hi! link DiagnosticUnderlineHint   DiagnosticUnderlineInfo
	hi! link DiagnosticVirtualTextHint DiagnosticVirtualTextInfo
]]
