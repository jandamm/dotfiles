if exists('g:loaded_terminal')
	finish
endif
let g:loaded_terminal = 1

" Here goes any global configuration for vim-terminal
" Any configuration that is local to terminal buffers should go in ftplugin

if !has($TMUX)
	tnoremap <C-SPACE><ESC> <C-\><C-n>
endif

let $VISUAL = 'nvr -cc split --remote-wait'
let $EDITOR = 'nvr'

augroup terminal_setup
	au!
	" Delete git buffers to work nicely with nvr
	autocmd FileType gitcommit,gitrebase,gitconfig set bufhidden=delete
augroup END
