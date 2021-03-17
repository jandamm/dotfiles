let s:temp = @p
normal! gg"pyG
wincmd c
normal! ggVG"pp
let @p = s:temp
global/\VAlready up to date./d
write!
quit
