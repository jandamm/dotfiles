require('luasnip').config.setup {
	history = true,
	store_selection_keys = '<TAB>',
	updateevents = 'TextChanged,TextChangedI', -- Update snippet nodes on every keystroke
	-- When to check if a snippet was removed
	delete_check_events = 'TextChanged,InsertLeave',
	-- Finish snippet when entering insert mode outside of the snippet
	-- region_check_events = 'InsertEnter', -- Not needed with delete_check_events
}

vim.cmd [[
		imap <silent><expr> <C-f> luasnip#jumpable(1)     ? '<Plug>luasnip-jump-next'   : '<C-f>'
		smap <silent><expr> <C-f> luasnip#jumpable(1)     ? '<Plug>luasnip-jump-next'   : '<C-f>'
		imap <silent><expr> <C-b> luasnip#jumpable(-1)    ? '<Plug>luasnip-jump-prev'   : '<C-b>'
		smap <silent><expr> <C-b> luasnip#jumpable(-1)    ? '<Plug>luasnip-jump-prev'   : '<C-b>'
		imap <silent><expr> <C-t> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-t>'
		smap <silent><expr> <C-t> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-t>'
		imap <silent><expr> <C-s> luasnip#choice_active() ? '<Plug>luasnip-prev-choice' : '<C-x><C-p>'
		smap <silent><expr> <C-s> luasnip#choice_active() ? '<Plug>luasnip-prev-choice' : '<C-x><C-p>'
]]

vim.cmd [[
	augroup my_luasnip
		autocmd!
		autocmd BufWritePost */lua/my/snippets.lua lua reload 'my.snippets'; vim.schedule(function() print('Reloaded snippets.') end)
	augroup END
]]

reload 'my.snippets'
