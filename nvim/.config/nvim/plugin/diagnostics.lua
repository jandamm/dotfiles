-- Signs
local groups = {
	{ name = 'Error', symbol = '✖' },
	{ name = 'Warning', symbol = '‼' },
	{ name = 'Information', symbol = 'i' },
	{ name = 'Hint', symbol = '⁇' },
}
for _, sign in pairs(groups) do
	local name = 'LspDiagnosticsSign' .. sign.name
	vim.fn.sign_define(name, { text=sign.symbol, texthl=name, linehl='', numhl='' })
end

-- Lsp customization {{{
local on_attach = function(client)
	if (client.name ~= 'vimls') then
		-- Default vim K is nicer jumping to the help
		vim.api.nvim_buf_set_keymap(0, 'n', 'K', '<CMD>lua vim.lsp.buf.hover()<CR>', {noremap = true})
	end
	vim.api.nvim_buf_set_keymap(0, 'n', 'gd', '<CMD>lua vim.lsp.buf.definition()<CR>', {noremap = true})
	vim.api.nvim_buf_set_keymap(0, 'n', '<C-w>gd', '<CMD>vsplit <BAR> lua vim.lsp.buf.definition()<CR>', {noremap = true})
	vim.api.nvim_buf_set_keymap(0, 'n', 'gr', '<CMD>lua vim.lsp.buf.references()<CR>', {noremap = true})
	vim.api.nvim_buf_set_keymap(0, 'n', 'gR', '<CMD>lua vim.lsp.buf.rename()<CR>', {noremap = true})
	if (client.server_capabilities.completionProvider ~= nil) then
		vim.o.omnifunc = 'v:lua.vim.lsp.omnifunc'
	end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
local default_config = {
	capabilities = capabilities,
	init_options = { usePlaceholders = true },
	on_attach = config_for_lsp
}

local lspconfig = require('lspconfig')

lspconfig.bashls.setup(default_config)
lspconfig.vimls.setup(default_config)
lspconfig.sourcekit.setup(default_config)

-- TODO: ios swift server
-- let g:lsc_server_commands['ios.swift'] = { 'command': ['neovim', 'swift', 'lsp', 'ios'], 'languageId': 'swift'}
-- let g:lsc_server_commands.sift = ['neovim', 'swift', 'lsp']

local null_ls = require('null-ls')
null_ls.config {
	sources = {
		null_ls.builtins.diagnostics.vint.with {
			extra_args = { "--enable-neovim" }
		},
		null_ls.builtins.diagnostics.markdownlint,
		null_ls.builtins.diagnostics.shellcheck
	}
}

lspconfig['null-ls'].setup {}
