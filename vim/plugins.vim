call plug#begin('~/.cache/plugged')

Plug 'jandamm/asyncomplete-fuzzy-match', {
			\ 'do': 'cargo build --release',
			\ }

" Usage
Plug 'tpope/vim-surround' " Add(y)/change(c)/remove(d) surroundings
Plug 'tpope/vim-repeat' " Add . macro to supported plugins
Plug 'justinmk/vim-sneak' " Add f like jumps with two chars
Plug 'tpope/vim-speeddating' " Fix i_Ctrl+a for dates
Plug 'tpope/vim-commentary' " gc to comment in/out
Plug 'junegunn/vim-easy-align' " ga to align
Plug 'tpope/vim-endwise' " Insert endif etc automatically
Plug 'majutsushi/tagbar' " Show file overview with tags
" Better iabbrev
" Better :s/abba/bobby/g with :S/{a,A}bba/{b,B}obby/g
" Change case styles with cr{char}
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-fugitive'

Plug 'airblade/vim-rooter' " Always cd into root of project

" Fuzzy finding
Plug 'junegunn/fzf.vim'
	Plug '/usr/local/opt/fzf'

" Themes
Plug 'rakr/vim-one'

" Ctags
Plug 'ludovicchabant/vim-gutentags'

" User Interface
Plug 'jandamm/vim-buftabline' " my fork until my PR is merged
Plug 'mhinz/vim-signify'

" Tmux
"Plug 'christoomey/vim-tmux-navigator'
"Plug 'christoomey/vim-tmux-runner'

" Auto Completion
Plug 'SirVer/ultisnips'
Plug 'prabirshrestha/asyncomplete.vim'
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
Plug 'zinit-zsh/zplugin-vim-syntax'

" Misc
" Asynchronous file linting/formatting
"Plug 'dense-analysis/ale'
Plug 'neomake/neomake'
Plug 'tweekmonster/startuptime.vim'

call plug#end()
