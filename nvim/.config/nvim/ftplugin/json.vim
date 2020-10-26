" Format pasted code to vsnip snippet json
command! -buffer -range VsnipSnip silent <line1>,<line2>s/"/\\"/ge
			\ | silent <line1>,<line2>s/\t/\\t/ge
			\ | silent <line1>,<line2>s/^/"/e
			\ | silent <line1>,<line2>s/$/",/e

augroup json_linter
	autocmd! * <buffer>
	autocmd BufWritePost <buffer> Lmake! jsonlint
augroup END
