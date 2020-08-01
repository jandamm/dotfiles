if exists('g:loaded_leader')
	finish
endif
let g:loaded_leader = 1

" Use Space as Leader
let mapleader = "\<space>"

" Setup Leader Guide
let g:lmap = {}
let g:bmap = {}
let g:leaderGuide_map = {' ' : g:lmap, '<buffer>': g:bmap}
nnoremap <silent> <leader> <CMD>LeaderGuide        '<Space>'<CR>
vnoremap <silent> <leader> <CMD>LeaderGuideVisual  '<Space>'<CR>

" Open cmdline when in LeaderGuide
let g:lmap[':'] = 'leader_ignore'
nmap <Leader>: :

" Leader Keybindings
nmap <silent> <Leader>b          :CtrlPBuffer<CR>
let g:lmap.b = 'Buffers'

" Leader C
" nmap <silent> <Leader>c          :call my#map#leader#compile()<CR>
let g:lmap.c = { 'name': 'code' }
nmap <silent> <Leader>cc         :call my#map#leader#compile()<CR>
let g:lmap.c.c = 'Compile'
nmap <silent> <Leader>cf         :call my#map#leader#format()<CR>
let g:lmap.c.f = 'Format'
nmap <silent> <Leader>cr         :call my#map#leader#run()<CR>
let g:lmap.c.r = 'Run'
nmap <silent> <Leader>cu         :call my#map#leader#test()<CR>
let g:lmap.c.u = 'Test'

function! s:dirvish(dir) abort
	let bang = winnr('$') == 1 ? '!' : ''
	execute 'Dirvish'.bang.a:dir
endfunction

" d -> Directory
nmap <silent> <Leader>d   :call <SID>dirvish('')<CR>
let g:lmap.d = 'Root-Directory'
nmap <silent> <Leader>D   :call <SID>dirvish('%')<CR>
let g:lmap.D = 'Directory'
" f -> Format

" Leader G
" Fugitive/Git
let g:lmap.g = { 'name': 'git' }
nmap <silent> <Leader>gb         :CtrlPGitBranch<CR>
nmap <silent> <Leader>gc         :Gcommit<CR>
nmap <silent> <Leader>gd         :Gvdiffsplit!<CR>
nmap <silent> <Leader>gf         :Gfetch<CR>
nmap <silent> <Leader>gF         :Gpull<CR>
nmap          <Leader>gg         :Git<SPACE>
let g:lmap.g.h = { 'name': 'hunk' }
nmap <silent> <Leader>ghd        :SignifyHunkDiff<CR>
nmap <silent> <Leader>ghu        :SignifyHunkUndo<CR>
let g:lmap.g.l = { 'name': 'log' }
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
let g:lmap.y = 'Yank history'
nmap          <Leader>Y          <Plug>(YoinkRotateForward)
let g:lmap.Y = 'Yank history forward'
nmap <silent> <Leader><SPACE>    :CtrlP<CR>
nmap <silent> <Leader><TAB>      :CtrlPObsession<CR>
let g:lmap['<C-I>'] = 'Sessions'
nmap <silent> <Leader>/          :CtrlPLine<CR>
nmap          <Leader>?          :Grep<SPACE>
let g:lmap['?'] = 'Grep'

" vim:set foldmethod=marker:
