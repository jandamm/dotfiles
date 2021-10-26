-- Fix building luarocks
-- https://github.com/wbthomason/packer.nvim/issues/180
vim.fn.setenv('MACOSX_DEPLOYMENT_TARGET', '11')

-- Relationships between packages:
-- required: ensure a plugin is installed
-- after:    only load plugin when another plugin is loaded
-- wants:    load specified plugin before this plugin

if not package.loaded['packer'] then
	require('packer').init {
		max_jobs = 8, -- Maybe this fixes the issue of not updating status sometimes
		auto_reload_compiled = false, -- Fixes breaking fugitive G and possibly others too
		profile = { enable = false },
	}
end

local use = require('packer').use
require('packer').reset()

-- Let packer update itself
use 'wbthomason/packer.nvim'

-- Apply fixes for nvim
use {
	-- Improve startup time of lua plugins
	'lewis6991/impatient.nvim',
	-- Fix CursorHold for nvim: https://github.com/neovim/neovim/issues/12587
	'antoinemadec/FixCursorHold.nvim',
}

-- Appearance
use {
	{
		'arcticicestudio/nord-vim',
		opt = true,
		setup = function()
			vim.g.nord_italic = 1
			vim.g.nord_italic_comments = 1
			vim.g.nord_uniform_diff_background = 1
			vim.g.nord_underline = 1
			vim.cmd [[colorscheme nord]]
		end,
	},
	{ 'kyazdani42/nvim-web-devicons' }, -- Icons for my statusline functions
}

-- Mappings
use {
	'tpope/vim-repeat', -- Add . macro to supported plugins

	{ -- Faster cursor movement
		'ggandor/lightspeed.nvim',
		config = function()
			vim.cmd [[
				nnoremap gs s
				xnoremap gs s
				omap ; <Plug>Lightspeed_;_ft
				omap , <Plug>Lightspeed_,_ft
			]]
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
	'tpope/vim-endwise', -- Insert endif etc automatically
	'tpope/vim-unimpaired', -- Better [] mappings
	'tommcdo/vim-exchange', -- Switch text with cx
	{ 'godlygeek/tabular', cmd = 'Tabularize' }, -- ga to align
	{
		'kwkarlwang/bufjump.nvim',
		keys = { 'g<C-i>', 'g<C-o>' },
		config = function()
			require('bufjump').setup { forward = 'g<C-i>', backward = 'g<C-o>' }
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
		setup = [[require'my.config.grepper']],
	},
	{ 'mhinz/vim-sayonara', cmd = 'Sayonara' }, -- Delete buffers but keep window alive
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
			require('gitsigns').setup()
			vim.cmd [[
				omap ah ih
				xmap ah ih
			]]
		end,
		requires = 'nvim-lua/plenary.nvim',
		tag = 'release',
		event = 'VimEnter', -- Otherwise it produces an error when a :Git buffer is open.
	},
	{ 'sindrets/diffview.nvim', requires = 'kyazdani42/nvim-web-devicons', cmd = { 'DiffviewOpen', 'Diffview*' } },
}

-- Utilities
use {
	'tpope/vim-sleuth', -- Automatically set spaces/tabs
	'chrisbra/Recover.vim', -- Allow comparing swap files
	'aymericbeaumet/vim-symlink', -- Resolve symlinks
	{ 'jghauser/mkdir.nvim', config = [[require('mkdir')]] }, -- Automatically create missing directories on :w
	'ludovicchabant/vim-gutentags', -- ctags now just work
	{ 'gabebw/vim-github-link-opener', branch = 'main', keys = 'gx' }, -- Improve gx mapping
}

-- Session management
use {
	'tpope/vim-obsession',
	'airblade/vim-rooter', -- Always cd into root of project
}

-- Project management
use {
	'tpope/vim-projectionist', -- Projects in vim
	'jandamm/vim-projplugin', -- Load project specific config
}

-- Show leader mappings
use {
	'jandamm/vim-leader-guide',
	{ 'jandamm/vim-fuguidive', after = 'vim-leader-guide' }, -- fugitive support
}

-- Improve quickfix lists
use {
	{
		'romainl/vim-qf',
		setup = function()
			vim.g.qf_auto_open_loclist = false
			vim.g.qf_auto_open_quickfix = false
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
use 'svermeulen/vim-yoink'

-- UI Elements
use {
	-- "default" Tabline with devicons
	{
		-- 'alvarosevilla95/luatab.nvim',
		'jandamm/luatab.nvim', -- until my pr is merged
		requires = 'kyazdani42/nvim-web-devicons',
		config = function()
			vim.o.tabline = "%!v:lua.require'luatab'.tabline('')"
		end,
	},
	-- Declare the status lines
	{ 'jandamm/cryoline.nvim', config = [[require 'my.config.cryoline']] },
}

-- Better text objects
use {
	'wellle/targets.vim',
	{
		'kana/vim-textobj-user',
		requires = {
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

-- Snippets
use {
	'hrsh7th/vim-vsnip',
	setup = function()
		vim.g.vsnip_snippet_dir = vim.fn.expand '~/.config/nvim/vsnip/default'
	end,
	requires = 'hrsh7th/vim-vsnip-integ',
}

-- Language support
-- LSP
use {
	'neovim/nvim-lspconfig',
	config = [[require 'my.config.lspconfig']],
	requires = {
		'folke/lua-dev.nvim', -- Config for sumneko-lua lsp (just needs to be in rtp)
		{
			'jose-elias-alvarez/null-ls.nvim', -- Linter/Formatter/Code Actions
			after = 'nvim-lspconfig',
			config = [[require 'my.config.null_ls']],
			requires = 'nvim-lua/plenary.nvim',
		},
	},
}
-- Syntax
use {
	'bfontaine/Brewfile.vim',
	'euclidianAce/BetterLua.vim',
	'tpope/vim-git',
	'keith/swift.vim',
	'cespare/vim-toml',
	'keith/xcconfig.vim',
	'jandamm/vim-xcode',
	'jandamm/vim-zsh-completion',
	'tpope/vim-scriptease', -- Vim debugging
	{ 'tjdevries/nlua.nvim', keys = 'K' }, -- nvim lua helper
}

use { 'tweekmonster/startuptime.vim', cmd = 'StartupTime' }