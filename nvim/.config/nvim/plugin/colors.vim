if exists('g:loaded_colors')
	finish
endif
let g:loaded_colors = 1

augroup my_colors
	autocmd!
	autocmd ColorScheme nord call s:nord()
augroup END

function! s:nord() abort
	if !exists('s:colors')
		let s:colors = NordPalette()
	endif

	execute 'hi Folded guibg='.s:colors.nord0

	execute 'hi StatusLine   guibg='.s:colors.nord3.' guifg='.s:colors.nord4
	execute 'hi StatusLineNC guibg='.s:colors.nord1.' guifg='.s:colors.nord4.' gui=italic'
	execute 'hi User1        guibg='.s:colors.nord3.' guifg='.s:colors.nord8.' gui=bold'
	execute 'hi User2        guibg='.s:colors.nord3.' guifg='.s:colors.nord13
	execute 'hi User3        guibg='.s:colors.nord3.' guifg='.s:colors.nord9
	execute 'hi User8        guibg='.s:colors.nord3.' guifg='.s:colors.nord4.' gui=bold'
	execute 'hi User9        guibg='.s:colors.nord3.' guifg='.s:colors.nord4
	execute 'hi QfStatus     guibg='.s:colors.nord3.' guifg='.s:colors.nord15
	execute 'hi QfStatusE    guibg='.s:colors.nord3.' guifg='.s:colors.nord11
	execute 'hi QfStatusW    guibg='.s:colors.nord3.' guifg='.s:colors.nord13
	execute 'hi QfStatusI    guibg='.s:colors.nord3.' guifg='.s:colors.nord9

	execute 'hi QfSign       guibg='.s:colors.nord0.' guifg='.s:colors.nord15
	execute 'hi QfSignE      guibg='.s:colors.nord0.' guifg='.s:colors.nord11
	execute 'hi QfSignW      guibg='.s:colors.nord0.' guifg='.s:colors.nord13
	execute 'hi QfSignI      guibg='.s:colors.nord0.' guifg='.s:colors.nord9

	execute 'hi LeaderGuideKeys            guibg='.s:colors.nord0.' guifg='.s:colors.nord13
	execute 'hi LeaderGuideMenu            guibg='.s:colors.nord0.' guifg='.s:colors.nord7
	execute 'hi LeaderGuideKeysStatusline  guibg='.s:colors.nord3.' guifg='.s:colors.nord13
	execute 'hi LeaderGuideMenuStatusline  guibg='.s:colors.nord3.' guifg='.s:colors.nord7
	hi! link LeaderGuideBrackets   Comment

	hi! link QuickScopePrimary ALEError
	hi! link QuickScopeSecondary ALEWarning

	execute 'hi helpExample  guibg='.s:colors.nord0.' guifg='.s:colors.nord10
endfunction

call s:nord()
