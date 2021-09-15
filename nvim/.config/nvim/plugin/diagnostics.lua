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
	if (client.name == 'lua') then
		-- ctags for lua aren't nice.
		vim.api.nvim_buf_set_keymap(0, 'n', '<C-]>', 'gd', {noremap = false})
		vim.api.nvim_buf_set_keymap(0, 'n', '<C-w><C-]>', '<C-w>gd', {noremap = false})
	end
	vim.api.nvim_buf_set_keymap(0, 'n', 'gd', '<CMD>lua vim.lsp.buf.definition()<CR>', {noremap = true})
	vim.api.nvim_buf_set_keymap(0, 'n', '<C-w>gd', '<CMD>vsplit <BAR> lua vim.lsp.buf.definition()<CR>', {noremap = true})
	vim.api.nvim_buf_set_keymap(0, 'n', 'gr', '<CMD>lua vim.lsp.buf.references()<CR>', {noremap = true})
	vim.api.nvim_buf_set_keymap(0, 'n', 'gR', '<CMD>lua vim.lsp.buf.rename()<CR>', {noremap = true})
	if (client.server_capabilities.completionProvider ~= nil) then
		vim.o.omnifunc = 'v:lua.vim.lsp.omnifunc'
	end
end

local function make_config()
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities.textDocument.completion.completionItem.snippetSupport = true
	return {
		capabilities = capabilities,
		init_options = { usePlaceholders = true },
		on_attach = on_attach
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
			telemetry = {
				enable = false,
			},
		}
	}
end
-- }}}

local lspconfig = require('lspconfig')
local lspinstall = require('lspinstall')

local function setup_servers()
	lspinstall.setup()
	local servers = require'lspinstall'.installed_servers()
	table.insert(servers, "bashls")
	table.insert(servers, "sourcekit")
	table.insert(servers, "vimls")

	for _, server in pairs(servers) do
		local config = make_config()
		if server == "lua" then
			config.settings = make_lua_settings()
		end
		if server == "sourcekit" then
			-- TODO: ios swift server
			-- let g:lsc_server_commands['ios.swift'] = { 'command': ['neovim', 'swift', 'lsp', 'ios'], 'languageId': 'swift'}
			-- let g:lsc_server_commands.sift = ['neovim', 'swift', 'lsp']
			config.filetypes = {"swift", "ios.swift", "ios"};
		end
		lspconfig[server].setup(config)
	end
end

setup_servers()

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
lspinstall.post_install_hook = function ()
	setup_servers() -- reload installed servers
	vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
end

-- Setup null-ls
local null_ls = require('null-ls')
null_ls.config {
	sources = {
		require('my.lint').jsonlint,
		null_ls.builtins.diagnostics.luacheck, -- TODO: Use packer instead of dotfiles bin
		null_ls.builtins.diagnostics.markdownlint,
		null_ls.builtins.diagnostics.shellcheck,
		require('my.lint').swiftlint,
		null_ls.builtins.diagnostics.vint.with { extra_args = { "--enable-neovim" } },
		require('my.lint').yamllint,
		require('my.lint').zsh,
		null_ls.builtins.code_actions.gitsigns
	}
}

lspconfig['null-ls'].setup {}
