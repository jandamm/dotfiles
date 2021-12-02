local s = require('my.symbols')
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
