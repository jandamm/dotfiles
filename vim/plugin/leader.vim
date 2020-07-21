if exists('g:loaded_leader')
	finish
endif
let g:loaded_leader = 1

" Use Space & \ as Leader
nmap <SPACE> <Leader>

" Leader Keybindings
nmap <silent> <Leader>b          :CtrlPBuffer<CR>

" Leader C
nmap <silent> <Leader>c          :call CodeCompile()<CR>
nmap <silent> <Leader>cc         :call CodeCompile()<CR>
nmap <silent> <Leader>cr         :call CodeRun()<CR>
nmap <silent> <Leader>cu         :call CodeTest()<CR>

" d -> Directory
nmap <expr> <silent> <Leader>d   winnr('$') == 1 ? ':Dirvish!<CR>' : ':Dirvish<CR>'
nmap <expr> <silent> <Leader>D   winnr('$') == 1 ? ':Dirvish! %<CR>' : ':Dirvish %<CR>'
" f -> Format
nmap <silent> <Leader>f          :call CodeFormat()<CR>

" Leader G
" Fugitive/Git
nmap <silent> <Leader>gb         :CtrlPGitBranch<CR>
nmap <silent> <Leader>gc         :Gcommit<CR>
nmap <silent> <Leader>gd         :Gvdiffsplit!<CR>
nmap <silent> <Leader>gf         :Gfetch<CR>
nmap <silent> <Leader>gF         :Gpull<CR>
nmap <silent> <Leader>gg         :Git<SPACE>
" h -> Hunk
nmap <silent> <Leader>ghd        :SignifyHunkDiff<CR>
nmap <silent> <Leader>ghu        :SignifyHunkUndo<CR>
nmap <silent> <Leader>glf        :0Glog<CR>
nmap <silent> <Leader>gll        :Glog<CR>
nmap <silent> <Leader>gm         :Gmerge<CR>
nmap <silent> <Leader>gp         :Gpush<CR>
nmap <silent> <Leader>gr         :Grebase<CR>
nmap <silent> <Leader>gs         :Gstatus<CR>
" w -> Who did this?
nmap <silent> <Leader>gw         :Gblame<CR>

nmap <silent> <Leader>l          <Plug>window:quickfix:loop
nmap <silent> <Leader>s          :call my#spelling#toggle()<CR>
nmap <silent> <Leader>t          :CtrlPTag<CR>
nmap <silent> <Leader>u          :UndotreeToggle<CR>
nmap <silent> <Leader><SPACE>    :CtrlP<CR>
nmap <silent> <Leader>/          :CtrlPLine<CR>
nmap          <Leader>?          :Grep<SPACE>

" Leader C functions {{{

" The following functions should be overwritten in ftplugin if necessary.
func CodeFormat() abort
	call my#format#trim()
	call my#format#reindent()
endfunc

func CodeCompile() abort
	echo s:NotDefined('compiler')
endfunc

func CodeRun() abort
	echo s:NotDefined('run')
endfunc

func CodeTest() abort
	echo s:NotDefined('test')
endfunc

func s:NotDefined(type) abort
	return '{' . a:type . '} is not defined for [' . &filetype . ']'
endfunc

" }}}

" vim:set foldmethod=marker:
