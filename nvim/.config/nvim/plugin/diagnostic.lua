local s = require 'my.symbols'
local groups = {
	{ name = 'Error', symbol = s.E },
	{ name = 'Warn', symbol = s.W },
	{ name = 'Info', symbol = s.I },
	{ name = 'Hint', symbol = s.H },
}

for _, sign in pairs(groups) do
	local name = 'DiagnosticSign' .. sign.name
	vim.fn.sign_define(name, { text = sign.symbol, texthl = name, linehl = '', numhl = '' })
end

-- Disable diagnostic in insert mode
-- TODO: Use ModeChanged when released
vim.cmd [[
	command -bar DiagnosticOn  lua require'my.diagnostic'.on()
	command -bar DiagnosticOff lua require'my.diagnostic'.off()
	command -bar Diagnostic    lua require'my.diagnostic'.toggle()

	augroup my_diagnostic
		autocmd!
		autocmd InsertEnter * lua require'my.diagnostic'.auto(true)
		autocmd InsertLeave * lua require'my.diagnostic'.auto(false)
	augroup END
]]
