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
		LSPDiagnosticsStatusE = status(colors.error),
		LSPDiagnosticsStatusW = status(colors.warn),
		LSPDiagnosticsStatusI = status(colors.info),
		TabLine = { fg = colors.fg, bg = colors.active },
		TabLineSel = { fg = colors.cyan, bg = colors.highlight },
		Whitespace = { fg = colors.selection },
		helpHyperTextJump = { fg = colors.orange },
	},
}

vim.cmd [[
	colorscheme onenord
	hi! link DiagnosticError LspDiagnosticsDefaultError
	hi! link DiagnosticWarn  LspDiagnosticsDefaultWarning
	hi! link DiagnosticInfo  LspDiagnosticsDefaultInformation
	hi! link DiagnosticHint  LspDiagnosticsDefaultHint
	hi! link LspDiagnosticsDefaultHint LspDiagnosticsDefaultInformation
	hi! link LspDiagnosticsFloatingHint LspDiagnosticsFloatingInformation
	hi! link LspDiagnosticsVirtualTextHint LspDiagnosticsVirtualTextInformation
	hi! link LspDiagnosticsSignHint LspDiagnosticsSignInformation
]]
