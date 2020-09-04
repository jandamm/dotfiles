if exists('g:loaded_projections')
	finish
endif
let g:loaded_projections = 1

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
			\  'compiler/*.vim': { 'type': 'compiler' },
			\  'ftdetect/*.vim': { 'type': 'detect' },
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
