if exists('g:loaded_projections')
	finish
endif
let g:loaded_projections = 1

" LUA {{{
let g:projectionist_heuristics['&lua/*.lua'] = {
			\  'lua/*.lua': { 'type': 'lua' },
			\ }
" }}}

" VIM {{{
let g:projectionist_heuristics['&*.vim'] = {
			\  'after/*.vim'    : { 'type': 'after'    },
			\  'autoload/*.vim' : { 'type': 'autoload' },
			\  'compiler/*.vim' : { 'type': 'compiler' },
			\  'ftdetect/*.vim' : { 'type': 'detect'   },
			\  'ftplugin/*.vim' : { 'type': 'ftplugin' },
			\  'plugin/*.vim'   : { 'type': 'plugin'   },
			\  'syntax/*.vim'   : { 'type': 'syntax'   },
			\  'doc/*.vim'      : { 'type': 'doc'      },
			\  'readme.md'      : { 'type': 'doc'      },
			\ }
" }}}

" VIMRC {{{
let g:projectionist_heuristics['&init.vim'] = {
			\  'ftplugin/*.vim': {
			\      'type': 'ftplugin',
			\      'alternate': 'autoload/my/ft/{}.vim',
			\      'related': ['after/ftplugin/{}.vim', 'autoload/my/ft/{}.vim'],
			\  },
			\  'after/ftplugin/*.vim': {
			\      'type': 'after',
			\      'alternate': 'ftplugin/{}.vim',
			\      'related': ['autoload/my/ft/{}.vim', 'ftplugin/{}.vim'],
			\  },
			\  'autoload/my/ft/*.vim': {
			\      'type': 'autoload',
			\      'alternate': 'ftplugin/{}.vim',
			\      'related': ['after/ftplugin/{}.vim', 'ftplugin/{}.vim'],
			\  },
			\  'plugin/*.vim': {
			\      'type': 'plugin',
			\      'alternate': 'autoload/my/{}.vim',
			\      'related': ['after/plugin/{}.vim', 'autoload/my/{}.vim'],
			\  },
			\  'after/plugin/*.vim': {
			\      'type': 'after',
			\      'alternate': 'plugin/{}.vim',
			\      'related': ['autoload/my/{}.vim', 'plugin/{}.vim'],
			\  },
			\  'autoload/my/*.vim': {
			\      'type': 'autoload',
			\      'alternate': 'plugin/{}.vim',
			\      'related': ['after/plugin/{}.vim', 'plugin/{}.vim'],
			\  },
			\  'init.vim': { 'type': 'init' },
			\  'plugin/ctrlp.vim': { 'type': 'ctrlp' },
			\  'autoload/ctrlp/*.vim': { 'type': 'ctrlp' },
			\  'projplugin/*.vim': { 'type': 'projplugin' },
			\  'vsnip/default/*.json': { 'type': 'snippet' },
			\  'spell/*.utf-8.add': { 'type': 'spell' },
			\ }
" }}}

" ZSHRC {{{
let g:projectionist_heuristics['&init.zsh'] = {
			\  'after/*': {
			\      'type': 'after',
			\  },
			\  'before/*': {
			\      'type': 'before',
			\  },
			\  'after/*.zsh': {
			\      'type': 'plugin',
			\  },
			\  'before/*.zsh': {
			\      'type': 'plugin',
			\  },
			\  'completions/_*': {
			\      'type': 'completion',
			\  },
			\  'init.zsh': { 'type': 'init' },
			\  'profile.zsh': { 'type': 'profile' },
			\  'login.zsh': { 'type': 'login' },
			\ }
" }}}
