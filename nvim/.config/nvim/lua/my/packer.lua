-- Sceleton copied from wbthomason
-- https://github.com/wbthomason/dotfiles/blob/2eefb38079e294b49e4b356a0f7f8e67acf83e96/neovim/.config/nvim/lua/plugins.lua

-- Fix building luarocks
-- https://github.com/wbthomason/packer.nvim/issues/180
vim.fn.setenv('MACOSX_DEPLOYMENT_TARGET', '11')

-- Relationships between packages:
-- required: ensure a plugin is installed
-- after:    only load plugin when another plugin is loaded
-- wants:    load specified plugin before this plugin

local packer = nil
local function init()
	if packer == nil then
		packer = require 'packer'
		packer.init { disable_commands = true }
	end

	local use = packer.use
	packer.reset()

	-- Let packer update itself
	use { 'wbthomason/packer.nvim', opt = true }

	-- Apply fixes for nvim
	use {
		-- Improve startup time of lua plugins
		'lewis6991/impatient.nvim',
		-- Fix CursorHold for nvim: https://github.com/neovim/neovim/issues/12587
		'antoinemadec/FixCursorHold.nvim',
	}

	-- Appearance
	use {
		{ 'arcticicestudio/nord-vim', opt = true },
		{ 'kyazdani42/nvim-web-devicons' }, -- Icons for my statusline functions
	}

	-- Mappings
	use {
		'tpope/vim-repeat', -- Add . macro to supported plugins

		'ggandor/lightspeed.nvim', -- Faster cursor movement
		'machakann/vim-sandwich', -- Add(y)/change(c)/remove(d) surroundings
		'tpope/vim-commentary', -- gc to comment in/out
		'tpope/vim-endwise', -- Insert endif etc automatically
		'tpope/vim-unimpaired', -- Better [] mappings
		'tommcdo/vim-exchange', -- Switch text with cx
		{ 'godlygeek/tabular', cmd = 'Tabularize' }, -- ga to align
	}

	-- Commands
	use {
		-- Better :s/abba/bobby/g with :S/{a,A}bba/{b,B}obby/g
		{ 'tpope/vim-abolish', cmd = { 'S', 'Subvert' } },
		'tpope/vim-eunuch', -- Unix commands in vim
		{ 'mhinz/vim-grepper', cmd = 'Grepper*' }, -- Win at grep
		{ 'mhinz/vim-sayonara', cmd = 'Sayonara' }, -- Delete buffers but keep window alive
	}
	-- Faster vim-abolish!
	use { 'jandamm/vim-abolisher', run = 'make build' }

	-- Git interface
	use {
		-- Fugitive
		{ 'tpope/vim-fugitive', disable = false },
		-- TODO: Find other statusline indicator?
		-- { "tpope/vim-fugitive", cmd = { "Git", "Gstatus", "Gblame", "Gpush", "Gpull", "G" } },
		{ 'tpope/vim-rhubarb', after = 'vim-fugitive' }, -- Gbrowse for Github
		{ 'shumphrey/fugitive-gitlab.vim', after = 'vim-fugitive' }, -- Gbrowse for GitLab
		{ 'tommcdo/vim-fubitive', after = 'vim-fugitive' }, -- Gbrowse for Bitbucket
		{ 'tommcdo/vim-fugitive-blame-ext', after = 'vim-fugitive' }, -- Gblame commit messages

		-- Other git plugins
		{
			'lewis6991/gitsigns.nvim',
			config = function()
				require('gitsigns').setup()
			end,
			requires = 'nvim-lua/plenary.nvim',
			tag = 'release',
		{ 'sindrets/diffview.nvim', requires = 'kyazdani42/nvim-web-devicons', cmd = { 'DiffviewOpen', 'Diffview*' } },

		-- For now fugitive is nicer since it allows jumping to old git objects as well. (Enter on emoved lines)
		-- Also fugitive jumps to the right line when enter is pressed.
		{
			'TimUntersberger/neogit',
			disable = true,
			requires = 'nvim-lua/plenary.nvim',
			config = function()
				require('neogit').setup { integrations = { diffview = true } }
			end,
		},
	}

	-- Utilities
	use {
		'tpope/vim-sleuth', -- Automatically set spaces/tabs
		'chrisbra/Recover.vim', -- Allow comparing swap files
		'ludovicchabant/vim-gutentags', -- ctags now just work
		{ 'tweekmonster/startuptime.vim', cmd = 'StartupTime' },
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
	use 'romainl/vim-qf'

	-- Netrw just in good
	use 'justinmk/vim-dirvish'

	-- Show undo history as a tree
	use { 'mbbill/undotree', cmd = 'UndotreeToggle' }

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
		{ 'jandamm/cryoline.nvim', config = require('my.config').cryoline },
	}

	-- Better text objects
	use {
		'wellle/targets.vim',
		{ 'kana/vim-textobj-entire', requires = 'kana/vim-textobj-user' },
		{ 'kana/vim-textobj-indent', requires = 'kana/vim-textobj-user' },
		{ 'kana/vim-textobj-line', requires = 'kana/vim-textobj-user' },
	}

	-- Dispatch
	use {
		{
			'tpope/vim-dispatch',
			cmd = { 'Dispatch', 'Make', 'Focus', 'Start' },
			setup = function()
				vim.g.dispatch_handlers = { 'neovim' }
			end,
		},
		{ 'jandamm/vim-dispatch-neovim', after = 'vim-dispatch' },
	}

	-- Snippets
	use {
		'hrsh7th/vim-vsnip',
		requires = 'hrsh7th/vim-vsnip-integ',
	}

	-- Language support
	-- LSP
	use {
		{ 'neovim/nvim-lspconfig', config = require('my.config').lspconfig },
		{ -- Linter/Formatter/Code Actions
			'jose-elias-alvarez/null-ls.nvim',
			after = 'nvim-lspconfig',
			config = require('my.config').null_ls,
			requires = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
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
	}
end

local plugins = setmetatable({}, {
	__index = function(_, key)
		init()
		return packer[key]
	end,
})

return plugins
