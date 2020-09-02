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

" Leader Keybindings

" Leader B {{{1
let g:lmap.b = { 'name': 'buffer' }
nmap <silent> <Leader>bb         :CtrlPBuffer<CR>
let g:lmap.b.b = 'Buffers'

" Leader C {{{1
let g:lmap.c = { 'name': 'code' }
nmap <silent> <Leader>c.         :AbortDispatch<CR>
let g:lmap.c['.'] = 'Abort Dispatch'
nmap <silent> <Leader>cc         :call my#map#leader#compile()<CR>
let g:lmap.c.c = 'Compile'
let g:quickfixsigns_echo_map = '<Leader>ce'
let g:lmap.c.e = 'Error message'
nmap <silent> <Leader>cf         :call my#map#leader#format()<CR>
let g:lmap.c.f = 'Format'
nmap <silent> <Leader>cr         :call my#map#leader#run()<CR>
let g:lmap.c.r = 'Run'
nmap <silent> <Leader>cu         :call my#map#leader#test()<CR>
let g:lmap.c.u = 'Test'

" Leader F {{{1
let g:lmap.f = { 'name': 'file' }
nmap <silent> <expr> <Leader>fd  winnr('$') == 1 ? ":Dirvish! %\<CR>" : ":Dirvish %\<CR>"
let g:lmap.f.d = 'Directory'
nmap <silent>        <Leader>fo  :!open %<CR>
let g:lmap.f.o = 'Open externally'
nmap <silent> <Leader>fw         :update<CR>
let g:lmap.f.w = 'Save'

" Leader G {{{1
let g:lmap.g = { 'name': 'git and more' }
nmap <silent> <Leader>gb         :CtrlPGitBranch<CR>

let g:git_messenger_no_default_mappings = v:true
nmap <silent> <Leader>gc         <Plug>(git-messenger)
let g:lmap.g.c = 'Show commit'

" Leader G D {{{2
let g:lmap.g.d = { 'name': 'diff' }
nmap <silent> <Leader>gdd        :Gvdiffsplit!<CR>
let g:lmap.g.d.d = 'Diff'
nmap <silent> <Leader>gdk        :Git ksdiffall<CR>
let g:lmap.g.d.k = 'Kaleidoscope'
nmap <silent> <Leader>gdo        :SignifyFold!<CR>
let g:lmap.g.d.o = 'Show only changes'
" }}}2
nmap <silent> <Leader>gf         :Gfetch<CR>
nmap <silent> <Leader>gF         :Gpull<CR>
nmap <silent> <Leader>gg         :cclose <BAR> lclose <BAR> Gstatus<CR>
let g:lmap.g.g = 'Fugitive'
" Leader G H {{{2
let g:lmap.g.h = { 'name': 'hunk' }
nmap <silent> <Leader>ghd        :SignifyHunkDiff<CR>
let g:lmap.g.h.d = 'Diff'
nmap <silent> <Leader>ghu        :SignifyHunkUndo<CR>
let g:lmap.g.h.u = 'Undo'
" }}}2
" Leader G L {{{2
let g:lmap.g.l = { 'name': 'log' }
nmap <silent> <Leader>glf        :0Gclog<CR>
let g:lmap.g.l.f = 'File'
nmap <silent> <Leader>gll        :Gclog<CR>
" }}}2
nmap <silent> <Leader>gm         :CtrlPModified<CR>
let g:lmap.g.m = 'Modified files'
nmap <silent> <Leader>gp         :Gpush<CR>
nmap <silent> <Leader>gr         :Grebase<CR>
" w -> Who did this?
nmap <silent> <Leader>gw         :Gblame<CR>
nmap          <Leader>g<Space>   :Git<SPACE>

" Leader O {{{1
let g:lmap.o = { 'name': 'open' }
nmap <silent> <Leader>og         :Gsh<CR>
let g:lmap.o.g = 'Gsh'
nmap <silent> <Leader>ot         :vsplit <BAR> terminal<CR>
let g:lmap.o.t = 'Terminal'

" Leader P {{{1
let g:lmap.p = { 'name': 'project' }
nmap <silent> <expr> <Leader>pd  winnr('$') == 1 ? ":Dirvish!\<CR>" : ":Dirvish\<CR>"
let g:lmap.p.d = 'Directory'
nmap <silent> <Leader>pp         :CtrlPSession<CR>
let g:lmap.p.p = 'Sessions'
nmap <silent> <Leader>pt         :CtrlPTag<CR>
let g:lmap.p.t = 'Tags'
nmap <silent> <Leader>pw         :wall<CR>
let g:lmap.p.w = 'Save'
" }}}

" vim-smalls
let g:lmap.s = 'Quicksearch'

" Leader T {{{1
let g:lmap.t = { 'name': 'toggle' }
nmap <silent> <Leader>tf         :call my#spelling#toggle()<CR>
let g:lmap.t.f = 'Spelling'
nmap <silent> <Leader>tl         <Plug>(qf_loc_toggle)
let g:lmap.t.l = 'Loclist'
nmap <silent> <Leader>tL         <Plug>(qf_loc_toggle_stay)
let g:lmap.t.L = 'Loclist stay'
nmap <silent> <Leader>tn         <CMD>setlocal relativenumber!<CR>
let g:lmap.t.n = 'Line numbers'
nmap <silent> <Leader>tp         <CMD>set paste!<CR>
xmap <silent> <Leader>tp         <CMD>set paste!<CR>
let g:lmap.t.p = 'Paste'
nmap <silent> <Leader>tq         <Plug>(qf_qf_toggle)
let g:lmap.t.q = 'Quickfix'
nmap <silent> <Leader>tQ         <Plug>(qf_qf_toggle_stay)
let g:lmap.t.Q = 'Quickfix stay'
nmap <silent> <Leader>ts         <CMD>QuickfixsignsToggle<CR>
let g:lmap.t.s = 'Signs'
nmap <silent> <Leader>tu         :UndotreeToggle<CR>
let g:lmap.t.u = 'Undotree'
" }}}

nmap          <Leader>y          <Plug>(YoinkRotateBack)
let g:lmap.y = 'Yank history'
nmap          <Leader>Y          <Plug>(YoinkRotateForward)
let g:lmap.Y = 'Yank history forward'
nmap <silent> <Leader><SPACE>    :CtrlP<CR>
let g:lmap[' '] = 'Files'
nmap <silent> <Leader><TAB>      :CtrlPSession<CR>
let g:lmap['<C-I>'] = 'Sessions'
nmap          <Leader>/          :Grep<SPACE>
let g:lmap['/'] = 'Grep'
nmap          <Leader>?          :Rg<SPACE>
let g:lmap['?'] = 'Rg'
nmap <Leader>: :CtrlPCmdPalette<CR>
let g:lmap[':'] = 'Commands'
