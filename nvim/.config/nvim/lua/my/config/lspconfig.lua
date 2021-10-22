local useful_K_maps = { 'vimls', 'sumneko_lua' }
-- Lsp customization
local on_attach = function(client)
	if not vim.tbl_contains(useful_K_maps, client.name) then
		-- Default vim K is nicer jumping to the help
		vim.api.nvim_buf_set_keymap(0, 'n', 'K', '<CMD>lua vim.lsp.buf.hover()<CR>', { noremap = true })
	end
	if client.name == 'sumneko_lua' then
		-- ctags for lua aren't nice.
		vim.api.nvim_buf_set_keymap(0, 'n', '<C-]>', 'gd', { noremap = false })
		vim.api.nvim_buf_set_keymap(0, 'n', '<C-w><C-]>', '<C-w>gd', { noremap = false })
	end
	vim.api.nvim_buf_set_keymap(0, 'n', 'gd', '<CMD>lua vim.lsp.buf.definition()<CR>', { noremap = true })
	vim.api.nvim_buf_set_keymap(
		0,
		'n',
		'<C-w>gd',
		'<CMD>vsplit <BAR> lua vim.lsp.buf.definition()<CR>',
		{ noremap = true }
	)
	vim.api.nvim_buf_set_keymap(0, 'n', 'gr', '<CMD>lua vim.lsp.buf.references()<CR>', { noremap = true })
	if client.server_capabilities.renameProvider ~= nil then
		-- The default gR is using a mapping with :%s/...
		vim.api.nvim_buf_set_keymap(0, 'n', 'gR', '<CMD>lua vim.lsp.buf.rename()<CR>', { noremap = true })
	end
	if client.server_capabilities.completionProvider ~= nil then
		vim.o.omnifunc = 'v:lua.vim.lsp.omnifunc'
	end
end

local function make_config()
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities.textDocument.completion.completionItem.snippetSupport = true
	return {
		capabilities = capabilities,
		init_options = { usePlaceholders = true },
		on_attach = on_attach,
	}
end

local function sumneko_lua()
	local config = make_config()
	config.cmd = { 'lua-language-server' }
	return require('lua-dev').setup { lspconfig = config }
end

local function sourcekit()
	local config = make_config()
	config.cmd = { 'neovim', 'swift', 'lsp' }
	config.filetypes = { 'swift' } -- also matches ios.swift
	config.get_language_id = function()
		return 'swift'
	end
	return config
end

local servers = {
	bashls = make_config,
	sourcekit = sourcekit,
	sumneko_lua = sumneko_lua,
	vimls = make_config,
}

local lspconfig = require 'lspconfig'
for server, get_config in pairs(servers) do
	lspconfig[server].setup(get_config())
end
