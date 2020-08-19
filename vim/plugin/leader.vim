if exists('g:loaded_leader')
	finish
endif
let g:loaded_leader = 1

" Use Space as Leader
let mapleader = "\<space>"

" Setup Leader Guide
let g:lmap = { 'name': 'Leader'}
let g:leaderGuide_map = {' ' : g:lmap}
nnoremap <silent> <leader> <CMD>LeaderGuide        '<Space>'<CR>
vnoremap <silent> <leader> <CMD>LeaderGuideVisual  '<Space>'<CR>

" Open cmdline when in LeaderGuide
let g:lmap[':'] = 'Commands'
nmap <Leader>: :CtrlPCmdPalette<CR>

" Leader Keybindings
let g:lmap.b = { 'name': 'buffer' }
nmap <silent> <Leader>bb         :CtrlPBuffer<CR>
let g:lmap.b.b = 'Buffers'

" Leader C
" nmap <silent> <Leader>c          :call my#map#leader#compile()<CR>
let g:lmap.c = { 'name': 'code' }
nmap <silent> <Leader>c.         :AbortDispatch<CR>
let g:lmap.c['.'] = 'Abort Dispatch'
nmap <silent> <Leader>cc         :call my#map#leader#compile()<CR>
let g:lmap.c.c = 'Compile'
nmap <silent> <Leader>cf         :call my#map#leader#format()<CR>
let g:lmap.c.f = 'Format'
nmap <silent> <Leader>cr         :call my#map#leader#run()<CR>
let g:lmap.c.r = 'Run'
nmap <silent> <Leader>cu         :call my#map#leader#test()<CR>
let g:lmap.c.u = 'Test'

let g:lmap.f = { 'name': 'file' }
nmap <silent> <expr> <Leader>fd  winnr('$') == 1 ? ":Dirvish! %\<CR>" : ":Dirvish %\<CR>"
let g:lmap.f.d = 'Directory'
nmap <silent>        <Leader>fo  :!open %<CR>
let g:lmap.f.o = 'Open externally'
nmap <silent> <Leader>fw         :update<CR>
let g:lmap.f.w = 'Save'

" Leader G
let g:lmap.g = { 'name': 'git and more' }
nmap <silent> <Leader>gb         :CtrlPGitBranch<CR>

let g:git_messenger_no_default_mappings = v:true
nmap <silent> <Leader>gc         <Plug>(git-messenger)
let g:lmap.g.c = 'Show commit'

let g:lmap.g.d = { 'name': 'diff' }
nmap <silent> <Leader>gdd        :Gvdiffsplit!<CR>
let g:lmap.g.d.d = 'Diff'
nmap <silent> <Leader>gdo        :SignifyFold!<CR>
let g:lmap.g.d.o = 'Show only changes'
nmap <silent> <Leader>gf         :Gfetch<CR>
nmap <silent> <Leader>gF         :Gpull<CR>
nmap          <Leader>g<Space>   :Git<SPACE>
nmap <silent> <Leader>gg         :Gstatus<CR>
let g:lmap.g.h = { 'name': 'hunk' }
nmap <silent> <Leader>ghd        :SignifyHunkDiff<CR>
let g:lmap.g.h.d = 'Diff'
nmap <silent> <Leader>ghu        :SignifyHunkUndo<CR>
let g:lmap.g.h.u = 'Undo'
let g:lmap.g.l = { 'name': 'log' }
nmap <silent> <Leader>glf        :0Glog<CR>
let g:lmap.g.l.f = 'File'
nmap <silent> <Leader>gll        :Glog<CR>
nmap <silent> <Leader>gm         :CtrlPModified<CR>
let g:lmap.g.m = 'Modified files'
nmap <silent> <Leader>gp         :Gpush<CR>
nmap <silent> <Leader>gr         :Grebase<CR>
" w -> Who did this?
nmap <silent> <Leader>gw         :Gblame<CR>

let g:lmap.o = { 'name': 'open' }
nmap <silent> <Leader>ot         :vsplit <BAR> terminal<CR>
let g:lmap.o.t = 'Terminal'

let g:lmap.p = { 'name': 'project' }
nmap <silent> <expr> <Leader>pd  winnr('$') == 1 ? ":Dirvish!\<CR>" : ":Dirvish\<CR>"
let g:lmap.p.d = 'Directory'
nmap <silent> <Leader>pp         :CtrlPObsession<CR>
let g:lmap.p.p = 'Sessions'
nmap <silent> <Leader>pt         :CtrlPTag<CR>
let g:lmap.p.t = 'Tags'
nmap <silent> <Leader>pw         :wall<CR>
let g:lmap.p.w = 'Save'

let g:lmap.s = 'Quicksearch'

let g:lmap.t = { 'name': 'toggle' }
nmap <silent> <Leader>tl         <Plug>window:quickfix:loop
let g:lmap.t.l = 'Quickfix'
nmap <silent> <Leader>ts         :call my#spelling#toggle()<CR>
let g:lmap.t.s = 'Spelling'
nmap <silent> <Leader>tu         :UndotreeToggle<CR>
let g:lmap.t.u = 'Undotree'

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
