-- Setup null-ls
local null_ls = require 'null-ls'
null_ls.config {
	sources = {
		-- DIAGNOSTICS
		require('my.lint').jsonlint,
		require('my.lint').kin,
		null_ls.builtins.diagnostics.luacheck,
		null_ls.builtins.diagnostics.markdownlint,
		null_ls.builtins.diagnostics.shellcheck,
		require('my.lint').swiftlint,
		null_ls.builtins.diagnostics.vint.with { extra_args = { '--enable-neovim' } },
		null_ls.builtins.diagnostics.yamllint,
		require('my.lint').zsh,

		-- FORMATTING
		null_ls.builtins.formatting.prettierd,
		null_ls.builtins.formatting.shfmt,
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.swiftformat.with {
			command = 'neovim',
			args = { 'swiftformat', '$ROOT' },
		},

		-- CODE_ACTIONS
		null_ls.builtins.code_actions.gitsigns,
	},
}

require('lspconfig')['null-ls'].setup {
	on_attach = function()
		if require('null-ls.info').get_active_sources()[null_ls.methods.FORMATTING] then
			vim.api.nvim_buf_set_keymap(
				0,
				'n',
				'<Leader>cf',
				'<CMD>lua vim.lsp.buf.formatting_sync()<CR>',
				{ noremap = true }
			)
		end
	end,
}
