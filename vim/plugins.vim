packadd vim-packager

" Setup {{{
call packager#init({ 'dir': '~/.vim/pack/packager', 'jobs': 0})

command! -nargs=+ -bar Pack call packager#add(<args>)
command! -nargs=+ -bar PackOpt call s:packOpt(<args>)
function! s:packOpt(name, ...) abort
	let opts = a:0 ? a:1 : {}
	let opts.type = 'opt'
	call packager#add(a:name, opts)
endfunction

call packager#add('kristijanhusak/vim-packager', { 'type': 'opt' })

" }}}

" Fix CursorHold for nvim: https://github.com/neovim/neovim/issues/12587
Pack 'antoinemadec/FixCursorHold.nvim'

" Usage
call packager#add('tpope/vim-surround') " Add(y)/change(c)/remove(d) surroundings
call packager#add('tpope/vim-repeat') " Add . macro to supported plugins
call packager#add('tpope/vim-speeddating') " Fix i_Ctrl+a for dates
call packager#add('tpope/vim-commentary') " gc to comment in/out
call packager#add('godlygeek/tabular') " ga to align
call packager#add('tpope/vim-endwise') " Insert endif etc automatically
call packager#add('psliwka/vim-smoothie') " Smoother scrolling
call packager#add('tpope/vim-abolish') " Better :s/abba/bobby/g with :S/{a,A}bba/{b,B}obby/g
call packager#add('jandamm/vim-abolisher', { 'do': 'make build' }) " Faster vim-abolish!
call packager#add('tpope/vim-unimpaired') " Better [] mappings
call packager#add('tpope/vim-fugitive') " Git interface
call packager#add('tpope/vim-rhubarb') " Gbrowse for Github
call packager#add('shumphrey/fugitive-gitlab.vim') " Gbrowse for GitLab
call packager#add('tommcdo/vim-fugitive-blame-ext') " Gblame commit messages
Pack 'roryokane/detectindent' " Automatically set spaces/tabs
call packager#add('tpope/vim-eunuch') " Unix commands in vim
call packager#add('tpope/vim-obsession') " Save sessions easily
call packager#add('airblade/vim-rooter') " Always cd into root of project
call packager#add('jandamm/vim-projplugin') " Load project specific config
call packager#add('mbbill/undotree') " Show undo history as a tree
call packager#add('machakann/vim-highlightedyank') " Highlight yanked text
call packager#add('rhysd/git-messenger.vim') " Quickly show last commit message
call packager#add('wellle/targets.vim') " Quickly show last commit message
Pack 'mhinz/vim-sayonara' " Delete buffers but keep window alive
call packager#add('svermeulen/vim-yoink') " Yank history
call packager#add('jandamm/vim-leader-guide') " Show leader mappings
call packager#add('jandamm/vim-fuguidive') " Show leader mappings for fugitive
Pack 'tommcdo/vim-exchange' " Switch text with cx
Pack 'tomtom/quickfixsigns_vim' " Show signs for qfl and more
Pack 'chrisbra/Recover.vim' " Allow comparing swap files
Pack 'romainl/vim-qf' " Improve quickfix lists
Pack 'tpope/vim-projectionist' " Projects in vim
Pack 'unblevable/quick-scope' " Highlight targets for f

call packager#add('justinmk/vim-dirvish')

" Fuzzy finding
call packager#add('ctrlpvim/ctrlp.vim')
call packager#add('nixprime/cpsm', { 'do': 'env PY3=ON ./install.sh' }) " Improve matching speed/accuracy for ctrlp
call packager#add('mattn/ctrlp-git')
call packager#add('jandamm/ctrlp-filer')
call packager#add('jandamm/ctrlp-complete.vim')
call packager#add('jandamm/ctrlp_bdelete.vim')
call packager#add('fisadev/vim-ctrlp-cmdpalette')
Pack 'jasoncodes/ctrlp-modified.vim'
call packager#add('ivalkeen/vim-ctrlp-tjump')

" Dispatching / Async
Pack 'hauleth/asyncdo.vim' " Easy dispatching for Grep
Pack 'tpope/vim-dispatch' " Easy dispatching of jobs to the terminal
Pack 'jandamm/vim-dispatch-neovim' " Dispatch using the neovim terminal

" Themes
PackOpt 'arcticicestudio/nord-vim'

" Ctags
call packager#add('ludovicchabant/vim-gutentags')

" User Interface
call packager#add('mhinz/vim-signify')

" Snippets
call packager#add('hrsh7th/vim-vsnip')
call packager#add('hrsh7th/vim-vsnip-integ')

" LSP
call packager#add('prabirshrestha/vim-lsp')

" Languages
call packager#add('sheerun/vim-polyglot')
call packager#add('keith/xcconfig.vim')

" Vim Plugins
call packager#add('junegunn/vader.vim')
call packager#add('tpope/vim-scriptease')

" iOS
Pack 'jandamm/vim-xcode'

" Misc
call packager#add('neomake/neomake')
call packager#add('tweekmonster/startuptime.vim', { 'type': 'opt' })
