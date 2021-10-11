-- Sceleton copied from wbthomason
-- https://github.com/wbthomason/dotfiles/blob/2eefb38079e294b49e4b356a0f7f8e67acf83e96/neovim/.config/nvim/lua/plugins.lua

-- Fix building luarocks
-- https://github.com/wbthomason/packer.nvim/issues/180
vim.fn.setenv("MACOSX_DEPLOYMENT_TARGET", "11")

local packer = nil
local function init()
	if packer == nil then
		packer = require("packer")
		packer.init({ disable_commands = true })
	end

	local use = packer.use
	packer.reset()

	-- Let packer update itself
	use({ "wbthomason/packer.nvim", opt = true })

	-- Improve startup time of lua plugins
	use("lewis6991/impatient.nvim")
	-- Fix CursorHold for nvim: https://github.com/neovim/neovim/issues/12587
	use("antoinemadec/FixCursorHold.nvim")

	use("nvim-lua/plenary.nvim") -- TODO: Dependency

	use({ "arcticicestudio/nord-vim", opt = true })

	use("machakann/vim-sandwich") -- Add(y)/change(c)/remove(d) surroundings
	use("tpope/vim-repeat") -- Add . macro to supported plugins
	use("tpope/vim-commentary") -- gc to comment in/out
	use("godlygeek/tabular") -- ga to align
	use("tpope/vim-endwise") -- Insert endif etc automatically
	use("tpope/vim-abolish") -- Better :s/abba/bobby/g with :S/{a,A}bba/{b,B}obby/g
	use({ "jandamm/vim-abolisher", run = "make build" }) -- Faster vim-abolish!
	use("tpope/vim-unimpaired") -- Better [] mappings
	use("tpope/vim-fugitive") -- Git interface
	use("tpope/vim-rhubarb") -- Gbrowse for Github
	use("shumphrey/fugitive-gitlab.vim") -- Gbrowse for GitLab
	use("tommcdo/vim-fubitive") -- Gbrowse for Bitbucket
	use("tommcdo/vim-fugitive-blame-ext") -- Gblame commit messages
	use("tpope/vim-sleuth") -- Automatically set spaces/tabs
	use("tpope/vim-eunuch") -- Unix commands in vim
	use("tpope/vim-obsession") -- Save sessions easily
	use("airblade/vim-rooter") -- Always cd into root of project
	use("jandamm/vim-projplugin") -- Load project specific config
	use("mbbill/undotree") -- Show undo history as a tree
	use("mhinz/vim-sayonara") -- Delete buffers but keep window alive
	use("svermeulen/vim-yoink") -- Yank history
	use("jandamm/vim-leader-guide") -- Show leader mappings
	use("jandamm/vim-fuguidive") -- Show leader mappings for fugitive
	use("tommcdo/vim-exchange") -- Switch text with cx
	use("chrisbra/Recover.vim") -- Allow comparing swap files
	use("romainl/vim-qf") -- Improve quickfix lists
	use("tpope/vim-projectionist") -- Projects in vim
	use("ggandor/lightspeed.nvim") -- Faster cursor movement
	use("mhinz/vim-grepper") -- Win at grep
	use("sindrets/diffview.nvim") -- Nicer diffing of the project files
	use("jandamm/cryoline.nvim") -- Declare the status lines
	use("justinmk/vim-dirvish") -- Netrw just in good
	use("wellle/targets.vim") -- Better text objects
	use("kana/vim-textobj-user") -- Better text objects
	use("kana/vim-textobj-entire") -- Better text objects
	use("kana/vim-textobj-indent") -- Better text objects
	use("kana/vim-textobj-line") -- Better text objects
	use("tpope/vim-dispatch") -- Easy dispatching of jobs to the terminal
	use("jandamm/vim-dispatch-neovim") -- Dispatch using the neovim terminal
	use("ludovicchabant/vim-gutentags") -- ctags just working
	use("lewis6991/gitsigns.nvim") -- Git signs and actions
	use("hrsh7th/vim-vsnip") -- Snippets
	use("hrsh7th/vim-vsnip-integ") -- Use snippets for more
	use("neovim/nvim-lspconfig") -- LSP
	use({ "jose-elias-alvarez/null-ls.nvim", rocks = "luacheck" }) -- Linter/Formatter to LSP

	-- Language support
	use("bfontaine/Brewfile.vim")
	use("euclidianAce/BetterLua.vim")
	use("tpope/vim-git")
	use("keith/swift.vim")
	use("cespare/vim-toml")
	use("keith/xcconfig.vim")
	use("jandamm/vim-xcode")
	use("jandamm/vim-zsh-completion")

	-- Vim debugging
	use("tpope/vim-scriptease")

	use({ "tweekmonster/startuptime.vim", opt = true })
end

local plugins = setmetatable({}, {
	__index = function(_, key)
		init()
		return packer[key]
	end,
})

return plugins
