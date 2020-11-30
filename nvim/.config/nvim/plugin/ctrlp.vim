" Don't use CtrlP
let g:ctrlp_map = ''
let g:ctrlp_cmd = ''

" Use better CtrlP matcher (CPSM)
let g:ctrlp_match_func = {'match': 'my#ctrlp#match'}

" Use own ctrlp statusline
let g:ctrlp_status_func = {
			\ 'main': 'my#statusline#ctrlp#main',
			\ 'prog': 'my#statusline#ctrlp#prog'
			\ }
