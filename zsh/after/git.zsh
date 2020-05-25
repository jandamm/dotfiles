# git -> git status.
function git() {
	if [ $# -eq 0 ]; then
		command git status --short --branch
	elif [ $# -eq 1 ] && [ $1 = 'r' ]; then
		r
	elif [ $1 = 'git' ]; then
		shift; g $@
	else
		command git $@
	fi
}

alias g=git

alias -g R='`git logf`'
alias -g RR='`git logfa`'
