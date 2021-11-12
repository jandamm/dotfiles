local cmp = require 'cmp'

local function close_and_default(fallback)
	cmp.close()
	fallback()
end
local select_next_item = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select }
local select_prev_item = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select }

cmp.setup {
	snippet = {
		expand = function(args)
			require('luasnip').lsp_expand(args.body)
		end,
	},
	formatting = {
		format = require('lspkind').cmp_format(),
	},
	completion = { autocomplete = false },
	mapping = {
		['<Down>'] = select_next_item,
		['<Up>'] = select_prev_item,

		-- TODO: migrate my#map#key#tab()
		-- See: https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings
		-- ['<TAB>'] = ...
		['<Plug>my-cmp-complete'] = cmp.mapping.complete(),
		['<Plug>my-cmp-next'] = select_next_item,
		['<S-TAB>'] = select_prev_item,

		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),

		-- TODO: Maybe migrate my#map#key#enter()
		['<CR>'] = cmp.mapping.confirm { select = true },
		['<C-e>'] = cmp.mapping {
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		},
		['<C-w>'] = close_and_default,
	},
	sources = cmp.config.sources {
		-- { name = 'nvim_lsp' }, -- lsp is enabled in lsp on_attach
		{ name = 'cmp_git' },
		{ name = 'zsh' },
		{ name = 'luasnip' },
	},
	experimental = { ghost_text = true },
}
