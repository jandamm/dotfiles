vim.g.mapleader = ' '

require('which-key').register {
	['<leader>'] = {
		name = 'Leader',
		-- TODO: Replace with Telescope
		b = { ':ls<CR>:buffer<Space>', 'Buffers', silent = false },
		c = {
			name = 'code',
			['.'] = { '<CMD>AbortDispatch<CR>', 'Abort Dispatch' },
			a = { '<CMD>lua vim.lsp.buf.code_action()<CR>', 'Action' },
			c = { '<CMD>call my#map#leader#compile()<CR>', 'Compile' },
			f = { '<CMD>call my#map#leader#format()<CR>', 'Format' },
			l = {
				'<CMD>lua vim.lsp.diagnostic.set_loclist({open_loclist = false}); vim.cmd [[lwindow]]<CR>',
				'Diagnostics',
			},
			r = { '<CMD>call my#map#leader#run()<CR>', 'Run' },
			u = { '<CMD>call my#map#leader#test()<CR>', 'Test' },
		},
		f = {
			name = 'file',
			-- TODO: Replace with Telescope
			-- nnoremap <leader>fs :sfind *
			-- nnoremap <leader>fv :vert sfind *
			-- nnoremap <leader>ft :tabfind *
			-- nnoremap <leader>fF :find <C-R>=expand('%:h').'/*'<CR>
			-- nnoremap <leader>fS :sfind <C-R>=expand('%:h').'/*'<CR>
			-- nnoremap <leader>fV :vert sfind <C-R>=expand('%:h').'/*'<CR>
			-- nnoremap <leader>fT :tabfind <C-R>=expand('%:h').'/*'<CR>
			d = { [[winnr('$') == 1 ? ":Dirvish! %\<CR>" : ":Dirvish %\<CR>"]], 'Directory', expr = true },
			f = { ':find *', 'Find file' },
			o = { '<CMD>!open %<CR>', 'Open externally' },
			w = { '<CMD>update<CR>', 'Save' },
		},
		g = {
			name = 'git',
			d = {
				name = 'diff',
				d = { '<CMD>DiffviewOpen<CR>', 'Diff' },
				f = { '<CMD>Gvdiffsplit!<CR>', 'Diff with Fugitive' },
				k = { '<CMD>Git ksdiffall<CR>', 'Kaleidoscope' },
			},
			f = { '<CMD>GG fetch<CR>', 'Fetch' },
			F = { '<CMD>GG pull<CR>', 'Pull' },
			g = { '<CMD>cclose<BAR>lclose<BAR>G<CR>', 'Fugitive' },
			h = {
				name = 'hunk',
				d = { '<CMD>lua require"gitsigns".preview_hunk()<CR>', 'Diff' },
				u = { '<CMD>lua require"gitsigns".reset_hunk()<CR>', 'Undo' },
			},
			l = {
				name = 'log',
				f = { '<CMD>GV!<CR>', 'File' },
				l = { '<CMD>GV<CR>', 'Log' },
			},
			p = { '<CMD>GG push<CR>', 'Push' },
			r = { '<CMD>GG rebase<CR>', 'Rebase' },
			R = { '<CMD>GG fetch && git rebase<CR>', 'Rebase from origin' },
			w = { '<CMD>G blame<CR>', 'Blame' },
			['<Space>'] = { ':G<Space>', 'Git', silent = false },
		},
		o = {
			name = 'open',
			-- nmap <silent> <Leader>od         :Dash<CR>
			g = { '<CMD>Gsh<CR>', 'Gsh' },
			G = { '<CMD>Gsh!<CR>', 'Gsh split' },
			t = { '<CMD>Terminal<CR>', 'Terminal' },
			T = { '<CMD>Terminal!<CR>', 'Terminal split' },
		},
		p = {
			name = 'project',
			d = { [[winnr('$') == 1 ? ":Dirvish!\<CR>" : ":Dirvish\<CR>"]], 'Directory', expr = true },
			p = { ':Session<Space>', 'Session', silent = false },
			t = { ':tjump<Space>/', 'Tags', silent = false },
			w = { '<CMD>wall<CR>', 'Save' },
		},
		t = {
			name = 'toggle',
			c = { '<CMD>call my#editor#case_sensitivity()<CR>', 'Case sensitivity' },
			l = { '<Plug>(qf_loc_toggle)', 'Loclist' },
			L = { '<Plug>(qf_loc_toggle_stay)', 'Loclist stay' },
			n = { '<CMD>setlocal relativenumber!<CR>', 'Line numbers' },
			p = { '<CMD>call my#map#leader#clipboard()<CR>', 'Paste' },
			-- xmap
			-- p =         {'<CMD>call my#map#leader#clipboard()<CR>', 'Paste' },
			q = { '<Plug>(qf_qf_toggle)', 'Quickfix' },
			Q = { '<Plug>(qf_qf_toggle_stay)', 'Quickfix stay' },
			s = { '<CMD>call my#spelling#toggle()<CR>', 'Spelling' },
			u = { '<CMD>UndotreeToggle<CR>', 'Undotree' },
		},
		y = { '<Plug>(YoinkRotateBack)', 'Yank history' },
		Y = { '<Plug>(YoinkRotateForward)', 'Yank history forward' },
		['<C-i>'] = { ':Session<Space>', 'Sessions', silent = false },
		['?'] = { ':GrepperRg<Space>', 'Rg', silent = false },
		['/'] = { ':GrepperAck<Space>', 'Ack', silent = false },
	},
}
