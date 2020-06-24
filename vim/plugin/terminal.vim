if exists('g:loaded_terminal')
	finish
endif
let g:loaded_terminal = 1

" Here goes any global configuration for vim-terminal
" Any configuration that is local to terminal buffers should go in ftplugin

if !has($TMUX)
	tnoremap <C-SPACE><ESC> <C-\><C-n>
	tmap     <C-SPACE>c     <C-\><C-n><C-SPACE>c
	tmap     <C-SPACE>g     <C-\><C-n><C-SPACE>g

	nnoremap <C-SPACE>c     :vsplit <BAR> terminal <CR>
	nnoremap <C-SPACE>g     :vsplit <BAR> terminal gsh <CR>
endif

let $VISUAL = 'nvr -cc split --remote-wait'
let $EDITOR = 'nvr'

augroup terminal_setup
	au!
	" Delete git buffers to work nicely with nvr
	autocmd FileType gitcommit,gitrebase,gitconfig set bufhidden=delete
augroup END
