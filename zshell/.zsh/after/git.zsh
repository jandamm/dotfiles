# git -> git status.
function g() {
	if [ $# -eq 0 ]; then
		if is_gsh; then
			command git status --short --branch
		else
			gsh
		fi
	elif [ $# -eq 1 ] && [ $1 = 'r' ]; then
		r
	elif [ $1 = 'git' ]; then
		shift; g $@
	else
		command git $@
	fi
}

alias -g R='`git logf`'
alias -g RR='`git logfa`'
