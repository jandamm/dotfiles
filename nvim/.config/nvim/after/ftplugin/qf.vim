nmap     <buffer> <C-b> <Plug>(qf_older)
nmap     <buffer> <C-f> <Plug>(qf_newer)
nnoremap <buffer> <C-n> j<CR><C-w>p
nnoremap <buffer> <C-p> k<CR><C-w>p
nmap     <buffer> X     <CMD>call my#ft#qf#removeEntry()<CR>
