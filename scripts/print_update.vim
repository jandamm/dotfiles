wincmd w
let s:temp = @p
normal! gg"pyG
wincmd c
normal! ggVG"pp
let @p = s:temp
write!
quit
