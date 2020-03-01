if exists('g:loaded_git_plugin')
	finish
endif
let g:loaded_git_plugin = 1

function! s:open_branch_fzf(line)
	let l:parser = split(a:line)
	let l:branch = l:parser[0]
	if l:branch ==? '*'
		let l:branch = l:parser[1]
	endif
	execute '!git switch ' . l:branch
endfunction

command! -bang -nargs=0 GSwitch
			\ call fzf#vim#grep(
			\   'git branch --verbose', 0,
			\   {
			\     'sink': function('s:open_branch_fzf')
			\   },
			\   <bang>0
			\ )
command! -bang -nargs=0 GSwitchAll
			\ call fzf#vim#grep(
			\   'git branch --all --verbose', 0,
			\   {
			\     'sink': function('s:open_branch_fzf')
			\   },
			\   <bang>0
			\ )
