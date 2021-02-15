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
			\  'Scripts/*.sh' : {
			\      'type': 'scripts',
			\      'template': ['#!/usr/bin/env bash', ''],
			\  },
			\ }
" }}}

" VIM {{{
let g:projectionist_heuristics['*.vim'] = { 'README.md': { 'type': 'doc' } }
" }}}
