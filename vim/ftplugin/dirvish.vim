" TODO: Improve this mapping.
"       - It does remove files as directories.
"       - It should confirm if currently in git tracked directory
nmap <buffer> D .rm -dr

" TODO: Improve this mapping.
"       - It should have a full path instead of %
"       - It should have a the filetype set?
nmap <buffer> M .mv<C-e> %/

" if exists('g:loaded_ft_dirvish')
"   finish
" endif
" let g:loaded_ft_dirvish = 1
