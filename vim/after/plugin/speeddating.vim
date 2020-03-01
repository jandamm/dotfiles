if exists('g:loaded_speeddating_after')
	finish
endif
let g:loaded_speeddating_after = 1

" Remove Roman Date Format (MMXV)
SpeedDatingFormat! %^v
SpeedDatingFormat! %v

" Support german dateformat
SpeedDatingFormat %d.%m.%Y
