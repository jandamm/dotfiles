-- Lsp customization
local on_attach = function(client)
	if client.name ~= 'vimls' then
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

-- Lua
local function make_lua_settings()
	local runtime_path = vim.split(package.path, ';')
	table.insert(runtime_path, 'lua/?.lua')
	table.insert(runtime_path, 'lua/?/init.lua')
	return {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = 'LuaJIT',
				-- Setup your lua path
				path = runtime_path,
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { 'vim' },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file('', true),
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = { enable = false },
		},
	}
end

local function sumneko_lua()
	local config = make_config()
	config.cmd = { 'lua-language-server' }
	config.settings = make_lua_settings()
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
