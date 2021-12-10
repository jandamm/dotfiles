local useful_K_maps = { 'vimls', 'sumneko_lua' }
local map = require('my.map').buffer.map

-- Lsp customization
local on_attach = function(client)
	if not vim.tbl_contains(useful_K_maps, client.name) then
		-- Default vim K is nicer jumping to the help
		map('K', '<CMD>lua vim.lsp.buf.hover()<CR>', 'Hover')
	end
	if client.name == 'sumneko_lua' then
		-- ctags for lua aren't nice.
		vim.o.tagfunc = [[v:lua.vim.lsp.tagfunc]]
	end
	map('gd', '<CMD>lua vim.lsp.buf.definition()<CR>', 'Go to definition')
	map('<C-w>gd', '<CMD>vsplit <BAR> lua vim.lsp.buf.definition()<CR>', 'Go to definition')
	map('gr', '<CMD>lua vim.lsp.buf.references()<CR>', 'Show callers')
	if client.server_capabilities.renameProvider ~= nil then
		-- The default gR is using a mapping with :%s/...
		map('gR', '<CMD>lua vim.lsp.buf.rename()<CR>', 'Rename')
	end
	if client.server_capabilities.completionProvider ~= nil then
		vim.o.omnifunc = 'v:lua.vim.lsp.omnifunc'
	end

	-- Call plugin specific config
	require('my.lsp').on_attach(client)
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
	local runtime_path = vim.split(package.path, ';')
	table.insert(runtime_path, 'lua/?.lua')
	table.insert(runtime_path, 'lua/?/init.lua')
	config.settings = {
		Lua = {
			runtime = { version = 'LuaJIT', path = runtime_path },
			completion = {
				callSnippet = 'Replace', -- Don't show snippet and duplicate function
				showWord = 'Disable',
				workspaceWord = false,
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file('', true),
				maxPreload = 1000,
				preloadFileSize = 150,
			},
			telemetry = { enable = false },
		},
	}
	return config
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

-- Disable virtual text and underline for unimportant messages
local severities = { vim.diagnostic.severity.ERROR, vim.diagnostic.severity.WARN }
vim.diagnostic.config {
	virtual_text = { severity = severities },
	underline = { severity = severities },
	severity_sort = true,
}
