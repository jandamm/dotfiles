set grepprg=ack\ -s\ -H\ --column
set grepformat=%f:%l:%c:%m,%f:%l:%m

nmap <silent> g/ <Plug>(GrepperOperator)
xmap <silent> g/ <Plug>(GrepperOperator)
