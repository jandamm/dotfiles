command! -bang -bar -nargs=? -complete=dir Dirvish if <bang>0 | vsplit | endif | call dirvish#open(<q-args>)
