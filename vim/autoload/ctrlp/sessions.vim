" =============================================================================
" File:          autoload/ctrlp/session.vim
" Description:   ctrlp session extension for ctrlp.vim
" =============================================================================

" Change the name of the g:loaded_ variable to make it unique
if ( exists('g:loaded_ctrlp_session') && g:loaded_ctrlp_session )
	finish
endif
let g:loaded_ctrlp_session = 1

" The main variable for this extension.
"
" The values are:
" + the name of the input function (including the brackets and any argument)
" + the name of the action function (only the name)
" + the long and short names to use for the statusline
" + the matching type: line, path, tabs, tabe
"                      |     |     |     |
"                      |     |     |     `- match last tab delimited str
"                      |     |     `- match first tab delimited str
"                      |     `- match full line like file/dir path
"                      `- match full line
let s:ctrlp_var = {
			\ 'init'  : 'ctrlp#sessions#init()',
			\ 'accept': 'ctrlp#sessions#accept',
			\ 'lname' : 'sessions',
			\ 'sname' : 'sess',
			\ 'type'  : 'line',
			\ 'sort'  : 0,
			\ 'nolim' : 1,
			\ }


" Append s:ctrlp_var to g:ctrlp_ext_vars
if exists('g:ctrlp_ext_vars') && !empty(g:ctrlp_ext_vars)
	let g:ctrlp_ext_vars = add(g:ctrlp_ext_vars, s:ctrlp_var)
else
	let g:ctrlp_ext_vars = [s:ctrlp_var]
endif


" Provide a list of strings to search in
"
" Return: command
function! ctrlp#sessions#init() abort
	return map(my#sessions#list(), { _, val -> substitute(val, '\.vim$', '', '') })
endfunction


" The action to perform on the selected string.
"
" Arguments:
"  a:mode   the mode that has been chosen by pressing <cr> <c-v> <c-t> or <c-x>
"           the values are 'e', 'v', 't' and 'h', respectively
"  a:str    the selected string
function! ctrlp#sessions#accept(mode, str) abort
	call ctrlp#exit()
	execute 'Session '.a:str.'.vim'
endfunction


" Give the extension an ID
let s:id = g:ctrlp_builtins + len(g:ctrlp_ext_vars)
" Allow it to be called later
function! ctrlp#sessions#id() abort
	return s:id
endfunction
