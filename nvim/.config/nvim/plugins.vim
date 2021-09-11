packadd vim-packager

" Setup {{{
call packager#init({ 'dir': expand('$XDG_DATA_HOME/nvim/site/pack/packager'), 'jobs': 0})

command! -buffer -nargs=+ -bar Pack call packager#add(<args>)
command! -buffer -nargs=+ -bar PackOpt call s:packOpt(<args>)
function! s:packOpt(name, ...) abort
	let opts = a:0 ? a:1 : {}
	let opts.type = 'opt'
	call packager#add(a:name, opts)
endfunction

call packager#add('kristijanhusak/vim-packager', { 'type': 'opt' })

" }}}

" Fix CursorHold for nvim: https://github.com/neovim/neovim/issues/12587
Pack 'antoinemadec/FixCursorHold.nvim'
Pack 'lewis6991/impatient.nvim'
Pack 'nvim-lua/plenary.nvim'

" Usage
call packager#add('tpope/vim-surround') " Add(y)/change(c)/remove(d) surroundings
call packager#add('tpope/vim-repeat') " Add . macro to supported plugins
call packager#add('tpope/vim-speeddating') " Fix i_Ctrl+a for dates
call packager#add('tpope/vim-commentary') " gc to comment in/out
call packager#add('godlygeek/tabular') " ga to align
call packager#add('tpope/vim-endwise') " Insert endif etc automatically
call packager#add('tpope/vim-abolish') " Better :s/abba/bobby/g with :S/{a,A}bba/{b,B}obby/g
call packager#add('jandamm/vim-abolisher', { 'do': 'make build' }) " Faster vim-abolish!
call packager#add('tpope/vim-unimpaired') " Better [] mappings
call packager#add('tpope/vim-fugitive') " Git interface
call packager#add('tpope/vim-rhubarb') " Gbrowse for Github
call packager#add('shumphrey/fugitive-gitlab.vim') " Gbrowse for GitLab
Pack 'tommcdo/vim-fubitive'
call packager#add('tommcdo/vim-fugitive-blame-ext') " Gblame commit messages
Pack 'roryokane/detectindent' " Automatically set spaces/tabs
call packager#add('tpope/vim-eunuch') " Unix commands in vim
call packager#add('tpope/vim-obsession') " Save sessions easily
call packager#add('airblade/vim-rooter') " Always cd into root of project
call packager#add('jandamm/vim-projplugin') " Load project specific config
call packager#add('mbbill/undotree') " Show undo history as a tree
call packager#add('rhysd/git-messenger.vim') " Quickly show last commit message
Pack 'mhinz/vim-sayonara' " Delete buffers but keep window alive
call packager#add('svermeulen/vim-yoink') " Yank history
call packager#add('jandamm/vim-leader-guide') " Show leader mappings
call packager#add('jandamm/vim-fuguidive') " Show leader mappings for fugitive
Pack 'tommcdo/vim-exchange' " Switch text with cx
Pack 'chrisbra/Recover.vim' " Allow comparing swap files
Pack 'romainl/vim-qf' " Improve quickfix lists
Pack 'tpope/vim-projectionist' " Projects in vim
Pack 'unblevable/quick-scope' " Highlight targets for f
Pack 'easymotion/vim-easymotion' " Faster cursor movement
Pack 'mhinz/vim-grepper'
Pack 'sindrets/diffview.nvim'

call packager#add('justinmk/vim-dirvish')

" Text Objects
Pack 'wellle/targets.vim'
Pack 'kana/vim-textobj-user'
Pack 'kana/vim-textobj-entire'
Pack 'kana/vim-textobj-indent'
Pack 'kana/vim-textobj-line'

" Fuzzy finding
Pack 'ctrlpvim/ctrlp.vim'
Pack 'nixprime/cpsm', { 'do': 'env PY3=ON ./install.sh' } " Improve matching speed/accuracy for ctrlp
Pack 'jandamm/ctrlp-complete.vim'

" Dispatching / Async
Pack 'tpope/vim-dispatch' " Easy dispatching of jobs to the terminal
Pack 'jandamm/vim-dispatch-neovim' " Dispatch using the neovim terminal

" Themes
PackOpt 'arcticicestudio/nord-vim'

" Ctags
call packager#add('ludovicchabant/vim-gutentags')

" User Interface
Pack 'lewis6991/gitsigns.nvim'

" Snippets
call packager#add('hrsh7th/vim-vsnip')
call packager#add('hrsh7th/vim-vsnip-integ')

" LSP
Pack 'neovim/nvim-lspconfig'
Pack 'jose-elias-alvarez/null-ls.nvim'

" Languages
Pack 'bfontaine/Brewfile.vim'
Pack 'tpope/vim-git'
" Pack 'plasticboy/vim-markdown'
" Pack 'gabrielelana/vim-markdown'
Pack 'keith/swift.vim'
Pack 'cespare/vim-toml'
Pack 'keith/xcconfig.vim'

" Vim Plugins
call packager#add('junegunn/vader.vim')
call packager#add('tpope/vim-scriptease')

" iOS
Pack 'jandamm/vim-xcode'

" Misc
Pack 'rizzatti/dash.vim'
call packager#add('tweekmonster/startuptime.vim', { 'type': 'opt' })
