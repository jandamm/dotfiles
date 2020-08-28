if exists('g:loaded_colors')
	finish
endif
let g:loaded_colors = 1

augroup my_colors
	autocmd!
	autocmd ColorScheme * call s:colors()
augroup END

let s:nord0_gui        = '#2E3440' " Dark
let s:nord1_gui        = '#3B4252' " Dark
let s:nord2_gui        = '#434C5E' " Dark
let s:nord3_gui        = '#4C566A' " Dark
let s:nord3_gui_bright = '#616E88' " Comment
let s:nord4_gui        = '#D8DEE9' " Light
let s:nord5_gui        = '#E5E9F0' " Light
let s:nord6_gui        = '#ECEFF4' " Light
let s:nord7_gui        = '#8FBCBB' " Blue
let s:nord8_gui        = '#88C0D0' " Blue
let s:nord9_gui        = '#81A1C1' " Blue
let s:nord10_gui       = '#5E81AC' " Blue
let s:nord11_gui       = '#BF616A' " Red
let s:nord12_gui       = '#D08770' " Orange
let s:nord13_gui       = '#EBCB8B' " Yellow
let s:nord14_gui       = '#A3BE8C' " Green
let s:nord15_gui       = '#B48EAD' " Purple

function! s:colors() abort
	if g:colors_name ==# 'one'
		hi! link User1 OneStatusLineHue2
		hi! link User2 OneStatusLineMono2
		hi! link User3 OneStatusLineHue62
	elseif g:colors_name ==# 'dracula'
		call s:define_User(1, g:dracula#palette.purple, g:dracula#palette.subtle)
		call s:define_User(2, [g:dracula#palette.color_8], g:dracula#palette.subtle)
		call s:define_User(3, g:dracula#palette.yellow, g:dracula#palette.subtle)
		hi! link Whitespace Comment
		hi! clear Statusline
		execute 'hi! Statusline guibg='.g:dracula#palette.subtle[0]
	elseif g:colors_name ==# 'nord'
		execute 'hi Folded guibg='.s:nord0_gui

		execute 'hi StatusLine   guibg='.s:nord3_gui.' guifg='s:nord4_gui
		execute 'hi StatusLineNC guibg='.s:nord1_gui.' guifg='s:nord4_gui.' gui=italic'
		execute 'hi User1        guibg='.s:nord3_gui.' guifg='s:nord8_gui.' gui=bold'
		execute 'hi User2        guibg='.s:nord3_gui.' guifg='s:nord4_gui
		execute 'hi User3        guibg='.s:nord3_gui.' guifg='s:nord13_gui
		execute 'hi User4        guibg='.s:nord3_gui.' guifg='s:nord5_gui.' gui=bold'
		execute 'hi QfStatus     guibg='.s:nord3_gui.' guifg='s:nord15_gui
		execute 'hi QfStatusE    guibg='.s:nord3_gui.' guifg='s:nord11_gui
		execute 'hi QfStatusW    guibg='.s:nord3_gui.' guifg='s:nord13_gui
		execute 'hi QfStatusI    guibg='.s:nord3_gui.' guifg='s:nord10_gui
		execute 'hi QfSign       guibg='.s:nord0_gui.' guifg='s:nord15_gui
		execute 'hi QfSignE      guibg='.s:nord0_gui.' guifg='s:nord11_gui
		execute 'hi QfSignW      guibg='.s:nord0_gui.' guifg='s:nord13_gui
		execute 'hi QfSignI      guibg='.s:nord0_gui.' guifg='s:nord10_gui
	endif
endfunction
function! s:define_User(num, fg, bg) abort
	exec 'hi! User'.a:num.' guifg='.a:fg[0].' guibg='.a:bg[0]
endfunction

call s:colors()
