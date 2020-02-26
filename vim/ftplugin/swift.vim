command! -nargs=* -buffer SwiftFormat call my#ft#swift#format('<args>')

" Leader Mapping {{{

nnoremap <silent> <Leader>f :SwiftFormat %<CR>

" }}}
