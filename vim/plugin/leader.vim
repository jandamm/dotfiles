if exists('g:loaded_leader')
	finish
endif
let g:loaded_leader = 1

" Use Space & \ as Leader
nmap <SPACE> <Leader>

" Leader Keybindings
nmap <silent> <Leader>b          :CtrlPBuffer<CR>

" Leader C
nmap <silent> <Leader>cc         :call my#map#leader#compile()<CR>
nmap <silent> <Leader>cr         :call my#map#leader#run()<CR>
nmap <silent> <Leader>cu         :call my#map#leader#test()<CR>

function! s:dirvish(dir) abort
	let bang = winnr('$') == 1 ? '!' : ''
	execute 'Dirvish'.bang.a:dir
endfunction

" d -> Directory
nmap <silent> <Leader>d   :call <SID>dirvish('')<CR>
nmap <silent> <Leader>D   :call <SID>dirvish('%')<CR>
" f -> Format
nmap <silent> <Leader>f          :call my#map#leader#format()<CR>

" Leader G
" Fugitive/Git
nmap <silent> <Leader>gb         :CtrlPGitBranch<CR>
nmap <silent> <Leader>gc         :Gcommit<CR>
nmap <silent> <Leader>gd         :Gvdiffsplit!<CR>
nmap <silent> <Leader>gf         :Gfetch<CR>
nmap <silent> <Leader>gF         :Gpull<CR>
nmap          <Leader>gg         :Git<SPACE>
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
nmap          <Leader>y          <Plug>(YoinkRotateBack)
nmap          <Leader>Y          <Plug>(YoinkRotateForward)
nmap <silent> <Leader><SPACE>    :CtrlP<CR>
nmap <silent> <Leader><TAB>      :CtrlPObsession<CR>
nmap <silent> <Leader>/          :CtrlPLine<CR>
nmap          <Leader>?          :Grep<SPACE>

" vim:set foldmethod=marker:
