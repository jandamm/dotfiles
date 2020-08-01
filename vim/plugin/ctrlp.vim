if exists('g:loaded_config_ctrlp')
	finish
endif
let g:loaded_config_ctrlp = 1

" Use C-p for Filer (Leader-Leader for CtrlP)
let g:ctrlp_cmd = 'CtrlPFiler'

" Make CtrlP use rg for listing the files. Way faster and no useless files.
let g:ctrlp_user_command = 'rg --files --hidden %s'
let g:ctrlp_use_caching = 0
let g:ctrlp_working_path_mode = 0 " Use vim-rooter else use 'g:ctrlp_root_markers'

let g:ctrlp_extensions = ['tags', 'git_branch', 'menu', 'lines', 'obsession', 'filer']

" Configure CtrlP Bdelete
let g:ctrlp_bdelete_keymap_trigger = '<c-x>'
let g:ctrlp_prompt_mappings = { 'AcceptSelection("h")': ['<c-cr>', '<c-s>'] }

" Configure CtrlP Filer
let g:ctrlp_filer_disable_lcd = 1
let g:ctrlp_filer_show_hidden = 1

" Use better CtrlP matcher (CPSM)
let g:ctrlp_match_func = {'match': 'my#ctrlp#match'}

" Add support for more buftag languages
let g:ctrlp_buftag_types = {
			\ 'swift' : '--language-force=swift --swift-types=drmf'
			\ }

" Use own ctrlp statusline
let g:ctrlp_status_func = {
			\ 'main': 'my#statusline#ctrlp#main',
			\ 'prog': 'my#statusline#ctrlp#prog'
			\ }

" Local extensions
command! CtrlPMenu call ctrlp#init(ctrlp#menu#id())
