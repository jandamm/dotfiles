-- Fix building luarocks
-- https://github.com/wbthomason/packer.nvim/issues/180
vim.fn.setenv('MACOSX_DEPLOYMENT_TARGET', '11')

-- Relationships between packages:
-- required: ensure a plugin is installed
-- after:    only load plugin when another plugin is loaded
-- wants:    load specified plugin before this plugin

if not package.loaded['packer'] then
	require('packer').init {
		max_jobs = 8, -- This fixes the issue of status hanging
		display = { keybindings = { quit = 'gq' } },
		profile = { enable = false },
	}
end

local use = require('packer').use
require('packer').reset()
unload 'my' -- Reset my config
vim.cmd [[autocmd! my_config]]

-- Let packer update itself
use { 'wbthomason/packer.nvim', setup = [[reload 'my.config.packer']] }

-- Apply fixes for nvim
use {
	-- Improve startup time of lua plugins
	'lewis6991/impatient.nvim',
	-- Fix CursorHold for nvim: https://github.com/neovim/neovim/issues/12587
	'antoinemadec/FixCursorHold.nvim',
}

use { 'nvim-lua/plenary.nvim', module = 'plenary' }

-- Appearance
use {
	{
		'rmehri01/onenord.nvim',
		opt = true,
		config = [[reload 'my.config.onenord']],
	},
	{
		'EdenEast/nightfox.nvim',
		config = [[reload 'my.config.nightfox']],
	},
	{ -- Icons for my statusline functions
		'kyazdani42/nvim-web-devicons',
		config = function()
			require('nvim-web-devicons').setup {
				override = {
					Gemfile = { icon = '', color = '#701516', name = 'Rb' },
					Podfile = { icon = '', color = '#701516', name = 'Rb' },
				},
			}
		end,
	},
}

-- Mappings
use {
	'tpope/vim-repeat', -- Add . macro to supported plugins

	{ -- Faster cursor movement
		'ggandor/lightspeed.nvim',
		config = function()
			require('lightspeed').setup {
				exit_after_idle_msecs = {}, -- don't exit when idle
			}
			require('my.map').register({
				x = 'Lightspeed exclusive',
				X = 'Lightspeed exclusive backwards',
				z = 'Lightspeed',
				Z = 'Lightspeed backwards',
				[';'] = { '<Plug>Lightspeed_;_ft', 'Repeat latest f or t' },
				[','] = { '<Plug>Lightspeed_,_ft', 'Repeat latest f or t in opposite direction' },
			}, 'o')
			require('my.map').map('gs', 's', 'Delete characters and start insert', { 'n', 'x' })
		end,
	},
	{ -- Add(y)/change(c)/remove(d) surroundings
		'machakann/vim-sandwich',
		config = function()
			vim.cmd [[runtime macros/sandwich/keymap/surround.vim]]
		end,
	},
	{
		'numToStr/Comment.nvim', -- gc to comment in/out
		config = function()
			require('Comment').setup { ignore = '^$', sticky = false }
		end,
	},
	'tpope/vim-unimpaired', -- Better [] mappings
	{ 'tommcdo/vim-exchange', config = [[require('my.map').name('cx', 'Exchange')]] }, -- Switch text with cx
	{ 'godlygeek/tabular', cmd = 'Tabularize', setup = [[reload 'my.config.tabular']] }, -- ga to align
	{
		'kwkarlwang/bufjump.nvim',
		keys = { 'g<C-i>', 'g<C-o>' },
		config = function()
			require('bufjump').setup { forward = 'g<C-i>', backward = 'g<C-o>' }
		end,
	},
}

-- Editing
use {
	{ 'tpope/vim-endwise', setup = [[vim.g.endwise_no_mappings=true]] }, -- Insert endif etc automatically
	-- Automatically add matching parens etc
	{
		'windwp/nvim-autopairs',
		config = function()
			local pairs = require 'nvim-autopairs'
			pairs.map_cr = function() end -- Use my own <CR> mapping
			pairs.setup {}
		end,
	},
}

-- Commands
use {
	-- Better :s/abba/bobby/g with :S/{a,A}bba/{b,B}obby/g
	{ 'tpope/vim-abolish', cmd = { 'S', 'Subvert' } },
	'tpope/vim-eunuch', -- Unix commands in vim
	{ -- Win at grep
		'mhinz/vim-grepper',
		cmd = { 'GrepperAck', 'Grepper*' },
		keys = '<Plug>(GrepperOperator)',
		setup = [[reload 'my.config.grepper']],
	},
	{ 'famiu/bufdelete.nvim', cmd = { 'Bdelete', 'Bwipeout' } }, -- Delete buffers but keep window alive
	{ 'powerman/vim-plugin-AnsiEsc', cmd = 'AnsiEsc' },
	{ 'sQVe/sort.nvim', cmd = 'Sort', config = [[require('sort').setup {}]] }, -- Like :sort but works for selections
}

-- Faster vim-abolish!
use { 'jandamm/vim-abolisher', run = 'make build' }

-- Git interface
use {
	-- Fugitive
	{
		'tpope/vim-fugitive',
		cmd = { 'G', 'G*' },
		fn = 'fugitive#Complete',
		event = 'BufAdd */.git/index',
		setup = function()
			vim.cmd [[
				autocmd my_config BufEnter */.git/index Git
				autocmd my_config BufReadPost fugitive://* nmap <buffer> gq <CMD>Bdelete<CR>
			]]
		end,
		requires = {
			{ 'tommcdo/vim-fugitive-blame-ext', after = 'vim-fugitive' }, -- Gblame commit messages
			{ 'junegunn/gv.vim', cmd = 'GV', wants = 'vim-fugitive' }, -- Better git log
			-- Gbrowse:
			{ 'tpope/vim-rhubarb', after = 'vim-fugitive' },
			{ 'shumphrey/fugitive-gitlab.vim', after = 'vim-fugitive' },
			{ 'tommcdo/vim-fubitive', after = 'vim-fugitive' },
		},
	},

	-- Other git plugins
	{
		'lewis6991/gitsigns.nvim',
		config = function()
			require('gitsigns').setup {
				signs = {
					add = { text = '┃' },
					change = { text = '┃' },
				},
			}
			vim.cmd [[
				omap ah ih
				xmap ah ih
			]]
		end,
		requires = 'nvim-lua/plenary.nvim',
		tag = 'release',
		event = 'VimEnter', -- Otherwise it produces an error when a :Git buffer is open.
	},
	{
		'sindrets/diffview.nvim',
		requires = 'kyazdani42/nvim-web-devicons',
		cmd = { 'DiffviewOpen', 'Diffview*' },
		config = function()
			vim.cmd [[autocmd my_config Filetype DiffviewFiles lua require'my.map'.buffer.map('gq', '<CMD>tabclose<CR>', 'Close Diffview')]]
		end,
	},
}

-- Utilities
use {
	-- Automatically set spaces/tabs
	{
		'tpope/vim-sleuth',
		setup = function()
			vim.cmd [[autocmd my_config Filetype * lua vim.schedule(function() if not vim.o.expandtab then vim.fn['my#format#default']() end end)]]
		end,
	},
	'aymericbeaumet/vim-symlink', -- Resolve symlinks
	-- Automatically create missing directories on :w
	{ 'jghauser/mkdir.nvim', config = [[require('mkdir')]] },
	-- ctags now just work
	{
		'ludovicchabant/vim-gutentags',
		setup = [[vim.g.gutentags_project_root = { '.root', '.tagroot' }]],
	},
	-- Improve gx mapping
	{ 'gabebw/vim-github-link-opener', branch = 'main', keys = 'gx' },
	-- Prevent opening files in some special buffers
	{ 'stevearc/stickybuf.nvim', config = [[require("stickybuf").setup()]] },
}

-- Session management
use {
	'tpope/vim-obsession',
	-- Always cd into root of project
	{
		'ahmedkhalf/project.nvim',
		config = function()
			require('project_nvim').setup {
				detection_methods = { 'pattern', 'lsp' },
				patterns = { '.root', '.vimroot', '.git', '.git/', 'Makefile', 'package.json' },
			}
		end,
	},
}

-- Project management
use {
	'tpope/vim-projectionist', -- Projects in vim
	'jandamm/vim-projplugin', -- Load project specific config
}

-- Show leader mappings
use {
	'folke/which-key.nvim',
	config = [[reload 'my.config.whichkey']],
}

-- Improve quickfix lists
use {
	{
		'romainl/vim-qf',
		setup = function()
			vim.g.qf_auto_open_loclist = false
			vim.g.qf_auto_open_quickfix = false

			-- TODO: migrate to lua
			vim.cmd [[
				nmap [l <Plug>(qf_loc_previous)
				nmap ]l <Plug>(qf_loc_next)
				nmap [q <Plug>(qf_qf_previous)
				nmap ]q <Plug>(qf_qf_next)
			]]
		end,
	},
	{
		'kevinhwang91/nvim-bqf',
		requires = { { 'junegunn/fzf', opt = true, config = [[vim.cmd 'silent! delcommand FZF']] } },
		wants = 'fzf',
		ft = 'qf',
	},
	{
		'https://gitlab.com/yorickpeterse/nvim-pqf',
		config = function()
			local s = require 'my.symbols'
			require('pqf').setup { signs = { error = s.E, warning = s.W, info = s.I, hint = s.H } }
		end,
	},
}

-- Netrw just in good
use 'justinmk/vim-dirvish'

-- Show undo history as a tree
use {
	'mbbill/undotree',
	cmd = 'UndotreeToggle',
	setup = function()
		vim.g.undotree_SetFocusWhenToggle = 1
		vim.cmd [[
				function! g:Undotree_CustomMap() abort
					map <buffer> U <C-r>
					map <buffer> gq <CMD>UndotreeHide<CR>
				endfunction
			]]
	end,
}

-- Yank history
use {
	'AckslD/nvim-neoclip.lua',
	requires = { 'tami5/sqlite.lua', module = 'sqlite' },
	config = function()
		require('neoclip').setup {
			history = 500,
			enable_persistant_history = true,
			filter = function(clip)
				local concat = table.concat(clip.event.regcontents, '')
				return not string.match(concat, '^%s*$')
			end,
			keys = {
				i = {
					paste = '<c-h>',
					paste_behind = '<c-k>',
				},
			},
		}
	end,
}

-- UI Elements
use {
	-- "default" Tabline with devicons
	{
		'alvarosevilla95/luatab.nvim',
		requires = 'kyazdani42/nvim-web-devicons',
		config = function()
			-- Disable highlighting
			require('luatab.highlight').create_component_highlight_group = function() end
			require('luatab.highlight').extract_highlight_colors = function() end
			require('luatab').setup {
				separator = function()
					return ''
				end,
			}
		end,
	},
	-- Declare the status lines
	{ 'jandamm/cryoline.nvim', config = [[reload 'my.config.cryoline']] },
	-- Override vim.ui.notify
	{
		'rcarriga/nvim-notify',
		config = function()
			vim.notify = require 'notify'
		end,
	},
	-- Override vim.ui.input and vim.ui.select
	{
		'stevearc/dressing.nvim',
		config = function()
			require('dressing').setup {
				input = { insert_only = false },
			}
		end,
	},
}

-- Better text objects
use {
	'wellle/targets.vim',
	{
		'kana/vim-textobj-user',
		requires = {
			'kana/vim-textobj-function',
			'kana/vim-textobj-entire',
			'kana/vim-textobj-indent',
			'kana/vim-textobj-line',
		},
	},
}

-- Dispatch
use {
	'tpope/vim-dispatch',
	cmd = { 'Dispatch', 'Make', 'Focus', 'Start' },
	setup = function()
		vim.g.dispatch_handlers = { 'neovim' }
	end,
	requires = { { 'jandamm/vim-dispatch-neovim', after = 'vim-dispatch' } },
}

-- Fuzzy finder
use {
	'nvim-telescope/telescope.nvim',
	cmd = 'Telescope',
	module = 'telescope',
	setup = function()
		require('my.lsp').register_on_attach(function()
			require('my.map').buffer.map('<leader>pt', '<CMD>Telescope lsp_dynamic_workspace_symbols<CR>', 'Search symbol')
		end)
	end,
	config = [[reload 'my.config.telescope']],
	requires = {
		'nvim-lua/plenary.nvim',
		{
			'nvim-telescope/telescope-fzf-native.nvim',
			run = 'make',
			config = [[require('telescope').load_extension 'fzf']],
			after = 'telescope.nvim',
		},
		{
			'nvim-telescope/telescope-frecency.nvim',
			after = 'telescope.nvim',
			config = [[require('telescope').load_extension 'frecency']],
			requires = 'tami5/sqlite.lua',
		},
		{
			'mrjones2014/dash.nvim',
			run = 'make install',
			after = 'telescope.nvim',
			cmd = 'Dash',
		},
	},
}

-- Completion
use {
	'hrsh7th/nvim-cmp',
	config = [[reload 'my.config.cmp']],
	requires = {
		'hrsh7th/cmp-nvim-lsp',
		{ 'tamago324/cmp-zsh', config = [[require 'cmp_zsh'.setup { zshrc = true }]] },
		{
			'hrsh7th/cmp-cmdline',
			requires = { 'hrsh7th/cmp-buffer' },
			config = function()
				require('cmp').setup.cmdline('/', {
					sources = { { name = 'buffer' } },
				})
			end,
		},
		{
			'petertriho/cmp-git',
			config = function()
				require('cmp_git').setup { remotes = { 'upstream', 'origin', 'fork' } }
			end,
			requires = 'nvim-lua/plenary.nvim',
		},

		'onsails/lspkind-nvim',
		{
			'L3MON4D3/LuaSnip',
			config = [[reload 'my.config.luasnip']],
			requires = 'saadparwaiz1/cmp_luasnip',
		},
	},
}

-- Language support
-- LSP
use {
	{
		'neovim/nvim-lspconfig',
		config = [[reload 'my.config.lspconfig']],
		requires = {
			'folke/lua-dev.nvim', -- Config for sumneko-lua lsp (just needs to be in rtp)
			{
				'jose-elias-alvarez/null-ls.nvim', -- Linter/Formatter/Code Actions
				after = 'nvim-lspconfig',
				config = [[reload 'my.config.null_ls']],
				requires = 'nvim-lua/plenary.nvim',
			},
		},
	},
	-- Reduce noice of diagnostics
	{
		'https://gitlab.com/yorickpeterse/nvim-dd',
		config = [[require('dd').setup()]],
	},
	{
		'kosayoda/nvim-lightbulb',
		config = function()
			vim.fn.sign_define(
				'LightBulbSign',
				{ text = require('my.symbols').bulb, texthl = 'ErrorMsg', linehl = '', numhl = '' }
			)
			vim.cmd [[
				autocmd my_config CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb{ ignore = {'null-ls'}}
			]]
		end,
	},
}
-- TreeSitter
use {
	'jandamm/nvim-treesitter',
	branch = 'swift',
	run = ':TSUpdate',
	requires = { { 'nvim-treesitter/playground', cmd = 'TSPlaygroundToggle' } },
	config = function()
		require('nvim-treesitter.configs').setup {
			ensure_installed = { 'bash', 'comment', 'lua', 'query', 'regex', 'swift', 'vim', 'yaml' },
			highlight = { enable = true },
			playground = { enable = true },
		}
	end,
}
-- Syntax
use {
	'bfontaine/Brewfile.vim',
	'tpope/vim-git',
	{
		'gabrielelana/vim-markdown',
		setup = function()
			vim.g.markdown_enable_mappings = false
			vim.g.markdown_enable_spell_checking = false
			vim.g.markdown_enable_input_abbreviations = false
		end,
	},
	'keith/swift.vim',
	'cespare/vim-toml',
	'keith/xcconfig.vim',
	{
		'jandamm/vim-xcode',
		setup = function()
			vim.g.xcode_default_simulator = 'iPhone 11 Pro'
			vim.g.xcode_runner_command = 'Dispatch! {cmd}'
			vim.g.xcode_disable_xcpretty = true
			vim.g.xcode_additional_xcargs = '-quiet 2>/dev/null'
			vim.g.xcode_additional_xcargs_test = '2>/dev/null | xcpretty --no-utf --color'
		end,
	},
	'tpope/vim-scriptease', -- Vim debugging
	{ 'tjdevries/nlua.nvim', keys = 'K' }, -- nvim lua helper
}

use { 'tweekmonster/startuptime.vim', cmd = 'StartupTime' }
