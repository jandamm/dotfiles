" TODO: Move to ios subtype

" Xcode {{{

let g:xcode_default_simulator = 'iPhone 11 Pro'
let g:xcode_runner_command = 'VtrSendCommandToRunner! {cmd}'

" }}}

" Leader Mapping {{{

nnoremap <Leader>c :Xbuild<CR>
nnoremap <Leader>r :Xrun<CR>
nnoremap <Leader>u :Xtest<CR>

" }}}
