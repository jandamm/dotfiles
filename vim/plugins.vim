call plug#begin('~/.cache/plugged')

Plug 'easymotion/vim-easymotion'

" Usage
Plug 'tpope/vim-surround' " Add(y)/change(c)/remove(d) surroundings
Plug 'tpope/vim-repeat' " Add . macro to supported plugins
Plug 'tpope/vim-speeddating' " Fix i_Ctrl+a for dates
Plug 'tpope/vim-commentary' " gc to comment in/out
Plug 'junegunn/vim-easy-align' " ga to align
Plug 'tpope/vim-endwise' " Insert endif etc automatically
Plug 'majutsushi/tagbar' " Show file overview with tags
" Better iabbrev
" Better :s/abba/bobby/g with :S/{a,A}bba/{b,B}obby/g
" Change case styles with cr{char}
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-unimpaired' " Better [] mappings
Plug 'tpope/vim-vinegar' " Improvements to netrw
Plug 'tpope/vim-fugitive' " Git interface
Plug 'tpope/vim-sleuth' " Automatically set spaces/tabs
Plug 'tpope/vim-eunuch' " Unix commands in vim

Plug 'airblade/vim-rooter' " Always cd into root of project

" Fuzzy finding
Plug 'junegunn/fzf.vim'
	Plug '/usr/local/opt/fzf'

" Themes
Plug 'jandamm/vim-one'

" Ctags
Plug 'ludovicchabant/vim-gutentags'

" User Interface
Plug 'mhinz/vim-signify'

" Tmux
Plug 'christoomey/vim-tmux-navigator' " C-hjkl movements with tmux
Plug 'christoomey/vim-tmux-runner'

" Auto Completion
Plug 'SirVer/ultisnips'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'jandamm/asyncomplete-fuzzy-match', { 'do': 'cargo build --release' }
Plug 'prabirshrestha/asyncomplete-necovim.vim'
	Plug 'Shougo/neco-vim'

" LSP
Plug 'prabirshrestha/vim-lsp'
	Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'thomasfaingnaert/vim-lsp-ultisnips'
	Plug 'thomasfaingnaert/vim-lsp-snippets'

" 'All' Languages
Plug 'sheerun/vim-polyglot'
Plug 'keith/xcconfig.vim'
Plug 'zinit-zsh/zinit-vim-syntax'

" iOS
Plug 'gfontenot/vim-xcode'

" Misc
Plug 'neomake/neomake'
Plug 'tweekmonster/startuptime.vim'

call plug#end()
