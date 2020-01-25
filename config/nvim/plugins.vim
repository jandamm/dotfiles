call plug#begin('~/.cache/plugged')

" Usage
Plug 'tpope/vim-surround' " Add(y)/change(c)/remove(d) surroundings
Plug 'tpope/vim-repeat' " Add . macro to supported plugins
Plug 'justinmk/vim-sneak' " Add f like jumps with two chars
Plug 'tpope/vim-speeddating' " Fix i_Ctrl+a for dates
Plug 'tpope/vim-commentary' " gc to comment in/out

" Fuzzy finding
Plug 'junegunn/fzf.vim'
	Plug '/usr/local/opt/fzf'

" Themes
Plug 'rakr/vim-one'

" Ctags
Plug 'ludovicchabant/vim-gutentags'

" User Interface
Plug 'ap/vim-buftabline'
Plug 'mhinz/vim-signify'

" Tmux
"Plug 'christoomey/vim-tmux-navigator'
"Plug 'christoomey/vim-tmux-runner'

" Auto Completion
Plug 'dustinknopoff/TeaCode-Vim-Extension'
Plug 'SirVer/ultisnips'
Plug 'prabirshrestha/asyncomplete.vim'

" LSP
Plug 'prabirshrestha/vim-lsp'
	Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'thomasfaingnaert/vim-lsp-snippets'
Plug 'thomasfaingnaert/vim-lsp-ultisnips'

" 'All' Languages
Plug 'sheerun/vim-polyglot'

" Misc
" Asynchronous file linting/formatting
"Plug 'dense-analysis/ale'
Plug 'neomake/neomake'

call plug#end()

" }}}
