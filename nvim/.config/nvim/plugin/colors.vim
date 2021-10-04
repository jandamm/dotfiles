augroup my_colors
	autocmd!
	autocmd ColorScheme nord call s:nord()
augroup END

function! s:nord() abort
	if !exists('s:colors')
		let s:colors = NordPalette()
	endif

	execute 'hi Folded guibg='.s:colors.nord0

	execute 'hi StatusLine            guibg='.s:colors.nord3.' guifg='.s:colors.nord4
	execute 'hi StatusLineNC          guibg='.s:colors.nord1.' guifg='.s:colors.nord4 .' gui=italic'
	execute 'hi User1                 guibg='.s:colors.nord3.' guifg='.s:colors.nord8 .' gui=bold'
	execute 'hi User2                 guibg='.s:colors.nord3.' guifg='.s:colors.nord13
	execute 'hi User3                 guibg='.s:colors.nord3.' guifg='.s:colors.nord9
	execute 'hi User8                 guibg='.s:colors.nord3.' guifg='.s:colors.nord4 .' gui=bold'
	execute 'hi User9                 guibg='.s:colors.nord3.' guifg='.s:colors.nord4
	execute 'hi LspDiagnosticsStatus  guibg='.s:colors.nord3.' guifg='.s:colors.nord15
	execute 'hi LspDiagnosticsStatusE guibg='.s:colors.nord3.' guifg='.s:colors.nord11
	execute 'hi LspDiagnosticsStatusW guibg='.s:colors.nord3.' guifg='.s:colors.nord13
	execute 'hi LspDiagnosticsStatusI guibg='.s:colors.nord3.' guifg='.s:colors.nord8
	execute 'hi LspDiagnosticsStatusH guibg='.s:colors.nord3.' guifg='.s:colors.nord10

	execute 'hi LeaderGuideKeys            guibg='.s:colors.nord0.' guifg='.s:colors.nord13
	execute 'hi LeaderGuideMenu            guibg='.s:colors.nord0.' guifg='.s:colors.nord7
	execute 'hi LeaderGuideKeysStatusline  guibg='.s:colors.nord3.' guifg='.s:colors.nord13
	execute 'hi LeaderGuideMenuStatusline  guibg='.s:colors.nord3.' guifg='.s:colors.nord7
	hi! link LeaderGuideBrackets   Comment

	execute 'hi LightspeedGreyWash               guifg='.s:colors.nord3_bright
	execute 'hi LightspeedLabel                  guifg='.s:colors.nord11                                .' gui=bold,underline'
	execute 'hi LightspeedLabelDistant           guifg='.s:colors.nord8                                 .' gui=bold,underline'
	execute 'hi LightspeedLabelDistantOverlapped guifg='.s:colors.nord7                                 .' gui=underline'
	execute 'hi LightspeedLabelOverlapped        guifg='.s:colors.nord12                                .' gui=underline'
	execute 'hi LightspeedMaskedChar             guifg='.s:colors.nord15
	execute 'hi LightspeedOneCharMatch           guifg='.s:colors.nord3       .' guibg='.s:colors.nord13.' gui=bold'
	execute 'hi LightspeedPendingChangeOpArea    guifg='.s:colors.nord11                                .' gui=strikethrough'
	execute 'hi LightspeedPendingOpArea          guifg='.s:colors.nord6       .' guibg='.s:colors.nord11
	execute 'hi LightspeedShortcut               guifg='.s:colors.nord6       .' guibg='.s:colors.nord11.' gui=bold,underline'
	execute 'hi LightspeedUnlabeledMatch         guifg='.s:colors.nord5                                 .' gui=bold'

	execute 'hi helpExample  guibg='.s:colors.nord0.' guifg='.s:colors.nord10
endfunction

call s:nord()
