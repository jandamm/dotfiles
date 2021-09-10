set grepprg=ack\ -s\ -H\ --column
set grepformat=%f:%l:%c:%m,%f:%l:%m

let g:grepper = {}
let g:grepper.tools = ['git', 'ack', 'rg', 'vimgrep']
let g:grepper.highlight = 1
let g:grepper.vimgrep = {
			\   'grepprg':    "nvim -es +'set nonu nornu | vimgrep /$*/ ** | cw | %p | qa'",
			\   'grepprgbuf': "nvim -es +'set nonu nornu | vimgrep /$*/ $. | cw | %p | qa'",
			\   'grepformat': '%f|%l col %c|%m'
			\ }

nmap <silent> g/ <Plug>(GrepperOperator)
xmap <silent> g/ <Plug>(GrepperOperator)
