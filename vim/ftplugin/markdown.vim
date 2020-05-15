call my#spelling#en()

" Remove when my PR is merged.
" https://github.com/neomake/neomake/pull/2487
let g:neomake_markdown_markdownlint_maker = {
                \ 'errorformat':
                \ '%f:%l:%c %m,%f: %l: %m,' .
                \ '%f:%l %m,%f: %l: %m'
                \ }
