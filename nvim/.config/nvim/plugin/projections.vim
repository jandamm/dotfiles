if exists('g:loaded_projections')
	finish
endif
let g:loaded_projections = 1

" LUA {{{
let g:projectionist_heuristics['lua/*.lua'] = {
			\  'lua/*.lua': { 'type': 'lua' },
			\ }
" }}}

" fastlane {{{
let g:projectionist_heuristics['fastlane/'] = {
			\  'fastlane/*file'    : { 'type': 'fastlane' },
			\  'fastlane/Fastfile' : { 'type': 'fastlane' },
			\ }
" }}}

" gitlab {{{
let g:projectionist_heuristics['.gitlab-ci.yml'] = {
			\  '.gitlab-ci.yml' : { 'type': 'gitlab' },
			\ }
" }}}

" cocoa pods {{{
let g:projectionist_heuristics['Podfile'] = {
			\  'Podfile' : { 'type': 'pods' },
			\ }
" }}}

" scripts {{{
let g:projectionist_heuristics['scripts/&!.zshenv&!nvim/'] = {
			\  'scripts/*.sh' : {
			\      'type': 'scripts',
			\      'template': ['#!/usr/bin/env bash', ''],
			\  },
			\ }
" }}}

" VIM {{{
let g:projectionist_heuristics['!nvim/.config/nvim/&*.vim'] = { 'readme.md': { 'type': 'doc' } }

let g:projectionist_heuristics['init.vim'] = {
			\  'ftplugin/*.vim': {
			\      'type': 'ftplugin',
			\      'alternate': 'autoload/my/ft/{}.vim',
			\      'related': ['after/ftplugin/{}.vim', 'autoload/my/ft/{}.vim'],
			\      'template': ["if exists('g:loaded_ft_{basename}')", "\tfinish", 'endif', 'let g:loaded_ft_{basename} = 1'],
			\  },
			\  'after/ftplugin/*.vim': {
			\      'type': 'after',
			\      'alternate': 'ftplugin/{}.vim',
			\      'related': ['autoload/my/ft/{}.vim', 'ftplugin/{}.vim'],
			\      'template': ["if exists('g:loaded_after_ft_{basename}')", "\tfinish", 'endif', 'let g:loaded_after_ft_{basename} = 1'],
			\  },
			\  'autoload/my/ft/*.vim': {
			\      'type': 'autoload',
			\      'alternate': 'ftplugin/{}.vim',
			\      'related': ['after/ftplugin/{}.vim', 'ftplugin/{}.vim'],
			\      'template': ["if exists('g:autoloaded_ft_{basename}')", "\tfinish", 'endif', 'let g:autoloaded_ft_{basename} = 1'],
			\  },
			\  'plugin/*.vim': {
			\      'type': 'plugin',
			\      'alternate': 'autoload/my/{}.vim',
			\      'related': ['after/plugin/{}.vim', 'autoload/my/{}.vim'],
			\      'template': ["if exists('g:loaded_{basename}')", "\tfinish", 'endif', 'let g:loaded_{basename} = 1'],
			\  },
			\  'after/plugin/*.vim': {
			\      'type': 'after',
			\      'alternate': 'plugin/{}.vim',
			\      'related': ['autoload/my/{}.vim', 'plugin/{}.vim'],
			\      'template': ["if exists('g:loaded_after_{basename}')", "\tfinish", 'endif', 'let g:loaded_after_{basename} = 1'],
			\  },
			\  'autoload/my/*.vim': {
			\      'type': 'autoload',
			\      'alternate': 'plugin/{}.vim',
			\      'related': ['after/plugin/{}.vim', 'plugin/{}.vim'],
			\      'template': ["if exists('g:autoloaded_my_{basename}')", "\tfinish", 'endif', 'let g:autoloaded_my_{basename} = 1'],
			\  },
			\  'compiler/*.vim'       : { 'type': 'compiler'   },
			\  'autoload/ctrlp/*.vim' : { 'type': 'ctrlp'      },
			\  'plugin/ctrlp.vim'     : { 'type': 'ctrlp'      },
			\  'ftdetect/*.vim'       : { 'type': 'ftdetect'   },
			\  'init.vim'             : { 'type': 'init'       },
			\  'projplugin/*.vim'     : { 'type': 'projplugin' },
			\  'syntax/*.vim'         : { 'type': 'syntax'     },
			\  'spell/*.utf-8.add'    : { 'type': 'spell'      },
			\  'vsnip/default/*.json' : { 'type': 'snippet'    },
			\ }
" }}}

" ZSHRC {{{
let g:projectionist_heuristics['init.zsh'] = {
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
			\  'zprofile.zsh': { 'type': 'profile' },
			\  'zlogin.zsh': { 'type': 'login' },
			\ }
" }}}
