command! -bang Mksession call my#sessions#make(<bang>0)

command! -bang -nargs=? -complete=customlist,my#sessions#complete Session   call my#sessions#load(<bang>0, <q-args>)
command!       -nargs=? -complete=customlist,my#sessions#complete Rmsession call my#sessions#delete(<q-args>)

command! Endsession call my#sessions#end()
