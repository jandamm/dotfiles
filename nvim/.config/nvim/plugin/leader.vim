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
nmap          <Leader>b          :ls<CR>:buffer<Space>
let g:lmap.b = 'Buffers'

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
nnoremap <leader>ff :find *
nnoremap <leader>fs :sfind *
nnoremap <leader>fv :vert sfind *
nnoremap <leader>ft :tabfind *
nnoremap <leader>fF :find <C-R>=expand('%:h').'/*'<CR>
nnoremap <leader>fS :sfind <C-R>=expand('%:h').'/*'<CR>
nnoremap <leader>fV :vert sfind <C-R>=expand('%:h').'/*'<CR>
nnoremap <leader>fT :tabfind <C-R>=expand('%:h').'/*'<CR>
nmap <silent>        <Leader>fo  :!open %<CR>
let g:lmap.f.o = 'Open externally'
nmap <silent> <Leader>fw         :update<CR>
let g:lmap.f.w = 'Save'

" Leader G {{{1
let g:lmap.g = { 'name': 'git and more' }
let g:git_messenger_no_default_mappings = v:true
nmap <silent> <Leader>gc         <Plug>(git-messenger)
let g:lmap.g.c = 'Show commit'

" Leader G D {{{2
let g:lmap.g.d = { 'name': 'diff' }
nmap <silent> <Leader>gdd        <CMD>DiffviewOpen<CR>
let g:lmap.g.d.d = 'Diff'
nmap <silent> <Leader>gdf        :Gvdiffsplit!<CR>
let g:lmap.g.d.f = 'Diff with Fugitive'
nmap <silent> <Leader>gdk        :G ksdiffall<CR>
let g:lmap.g.d.k = 'Kaleidoscope'
nmap <silent> <Leader>gdo        :SignifyFold!<CR>
let g:lmap.g.d.o = 'Show only changes'
" }}}2
nmap <silent> <Leader>gf         :G fetch<CR>
nmap <silent> <Leader>gF         :G pull<CR>
nmap <silent> <Leader>gg         :cclose <BAR> lclose <BAR> G<CR>
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
nmap <silent> <Leader>glf        :0Gclog -n 100<CR>
let g:lmap.g.l.f = 'File'
nmap <silent> <Leader>gll        :Gclog -n 100<CR>
" }}}2
nmap <silent> <Leader>gp         :G push<CR>
nmap <silent> <Leader>gr         :G rebase<CR>
" w -> Who did this?
nmap <silent> <Leader>gw         :G blame<CR>
nmap          <Leader>g<Space>   :G<SPACE>

" Leader O {{{1
let g:lmap.o = { 'name': 'open' }
nmap <silent> <Leader>od         :Dash<CR>
let g:lmap.o.d = 'Dash'
nmap <silent> <Leader>og         :Gsh<CR>
let g:lmap.o.g = 'Gsh'
nmap <silent> <Leader>oG         :Gsh!<CR>
let g:lmap.o.G = 'Gsh split'
nmap <silent> <Leader>ot         :Terminal<CR>
let g:lmap.o.t = 'Terminal'
nmap <silent> <Leader>oT         :Terminal!<CR>
let g:lmap.o.T = 'Terminal split'

" Leader P {{{1
let g:lmap.p = { 'name': 'project' }
nmap <silent> <expr> <Leader>pd  winnr('$') == 1 ? ":Dirvish!\<CR>" : ":Dirvish\<CR>"
let g:lmap.p.d = 'Directory'
nmap          <Leader>pp         :Session<Space>
let g:lmap.p.p = 'Sessions'
nmap          <Leader>pt         :tjump<Space>/
let g:lmap.p.t = 'Tags'
nmap <silent> <Leader>pw         :wall<CR>
let g:lmap.p.w = 'Save'
" }}}
" Leader T {{{1
let g:lmap.t = { 'name': 'toggle' }
nmap <silent> <Leader>tc         <CMD>call my#editor#case_sensitivity()<CR>
let g:lmap.t.c = 'Case sensitivity'
nmap <silent> <Leader>tf         :call my#spelling#toggle()<CR>
let g:lmap.t.f = 'Spelling'
nmap <silent> <Leader>tl         <Plug>(qf_loc_toggle)
let g:lmap.t.l = 'Loclist'
nmap <silent> <Leader>tL         <Plug>(qf_loc_toggle_stay)
let g:lmap.t.L = 'Loclist stay'
nmap <silent> <Leader>tn         <CMD>setlocal relativenumber!<CR>
let g:lmap.t.n = 'Line numbers'
nmap <silent> <Leader>tp         <CMD>call my#map#leader#clipboard()<CR>
xmap <silent> <Leader>tp         <CMD>call my#map#leader#clipboard()<CR>
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
let g:lmap[' '] = 'EasyMotion'
nmap <silent> <Leader><TAB>      :Session<Space>
let g:lmap['<C-I>'] = 'Sessions'
nmap          <Leader>?          :GrepperRg<SPACE>
let g:lmap['?'] = 'Rg'
nmap          <Leader>/          :GrepperAck<SPACE>
let g:lmap['/'] = 'Ack'
