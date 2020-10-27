setlocal foldmethod=marker
setlocal foldmarker={{{,}}}

call my#map#apply#tagInclude(':')

call my#lint#setup('vint')
