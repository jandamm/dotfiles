if exists('g:loaded_config_ctrlp')
	finish
endif
let g:loaded_config_ctrlp = 1

" Make CtrlP use rg for listing the files. Way faster and no useless files.
let g:ctrlp_user_command = 'rg --files --hidden %s'
let g:ctrlp_use_caching = 0
let g:ctrlp_working_path_mode = 0 " Use vim-rooter else use 'g:ctrlp_root_markers'

" Configure CtrlP Bdelete
let g:ctrlp_bdelete_keymap_trigger = '<c-x>'
let g:ctrlp_prompt_mappings = { 'AcceptSelection("h")': ['<c-cr>', '<c-s>'] }

" Use better CtrlP matcher (CPSM)
let g:ctrlp_match_func = {'match': 'cpsm#CtrlPMatch'}
