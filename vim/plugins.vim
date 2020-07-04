packadd vim-packager

call packager#init({ 'dir': '~/.vim/pack/packager', 'jobs': 0})

call packager#add('kristijanhusak/vim-packager', { 'type': 'opt' })

" Usage
call packager#add('tpope/vim-surround') " Add(y)/change(c)/remove(d) surroundings
call packager#add('tpope/vim-repeat') " Add . macro to supported plugins
call packager#add('tpope/vim-speeddating') " Fix i_Ctrl+a for dates
call packager#add('tpope/vim-commentary') " gc to comment in/out
call packager#add('junegunn/vim-easy-align') " ga to align
call packager#add('tpope/vim-endwise') " Insert endif etc automatically
call packager#add('majutsushi/tagbar') " Show file overview with tags
" Better iabbrev
" Better :s/abba/bobby/g with :S/{a,A}bba/{b,B}obby/g
" Change case styles with cr{char}
call packager#add('tpope/vim-abolish')
call packager#add('jandamm/vim-abolisher', { 'do': 'make build' }) " Faster vim-abolish!
call packager#add('tpope/vim-unimpaired') " Better [] mappings
call packager#add('tpope/vim-fugitive') " Git interface
call packager#add('tpope/vim-rhubarb') " Gbrowse for Github
call packager#add('shumphrey/fugitive-gitlab.vim') " Gbrowse for GitLab
call packager#add('tpope/vim-sleuth') " Automatically set spaces/tabs
call packager#add('tpope/vim-eunuch') " Unix commands in vim
call packager#add('tpope/vim-obsession') " Save sessions easily
call packager#add('dhruvasagar/vim-prosession') " Automatically save/load sessions
call packager#add('airblade/vim-rooter') " Always cd into root of project
call packager#add('easymotion/vim-easymotion') " Quick moving of the cursor
call packager#add('drmingdrmer/vim-toggle-quickfix') " Toggle QF and Loc List
call packager#add('mbbill/undotree') " Show undo history as a tree
call packager#add('machakann/vim-highlightedyank') " Highlight yanked text
call packager#add('dhruvasagar/vim-zoom') " Zoom current window with m

call packager#add('justinmk/vim-dirvish')
" call packager#add('kristijanhusak/vim-dirvish-git')

" Fuzzy finding
call packager#add('ctrlpvim/ctrlp.vim')
call packager#add('nixprime/cpsm', { 'do': 'env PY3=ON ./install.sh' }) " Improve matching speed/accuracy for ctrlp
call packager#add('mattn/ctrlp-git')

" Themes
call packager#add('jandamm/vim-one')

" Ctags
call packager#add('ludovicchabant/vim-gutentags')

" User Interface
call packager#add('mhinz/vim-signify')

" Tmux
call packager#add('christoomey/vim-tmux-navigator', { 'type': 'opt' }) " C-hjkl movements with tmux

" Auto Completion
call packager#add('SirVer/ultisnips')
call packager#add('prabirshrestha/asyncomplete.vim')
call packager#add('jandamm/asyncomplete-fuzzy-match', { 'do': 'cargo build --release' })
call packager#add('prabirshrestha/asyncomplete-necovim.vim')
	call packager#add('Shougo/neco-vim')

" LSP
call packager#add('prabirshrestha/vim-lsp')
	call packager#add('prabirshrestha/async.vim')
call packager#add('prabirshrestha/asyncomplete-lsp.vim')
call packager#add('thomasfaingnaert/vim-lsp-ultisnips')
	call packager#add('thomasfaingnaert/vim-lsp-snippets')

" Languages
call packager#add('sheerun/vim-polyglot')
call packager#add('keith/xcconfig.vim')
call packager#add('junegunn/vader.vim')

" iOS
call packager#add('gfontenot/vim-xcode')

" Misc
call packager#add('neomake/neomake', { 'type': 'opt' })
call packager#add('tweekmonster/startuptime.vim', { 'type': 'opt' })
