local groups = {
	{ name = 'Error', symbol = '✖' },
	{ name = 'Warning', symbol = '‼' },
	{ name = 'Information', symbol = 'i' },
	{ name = 'Hint', symbol = '⁇' },
}

for _, sign in pairs(groups) do
	local name = 'LspDiagnosticsSign' .. sign.name
	vim.fn.sign_define(name, { text = sign.symbol, texthl = name, linehl = '', numhl = '' })
end
