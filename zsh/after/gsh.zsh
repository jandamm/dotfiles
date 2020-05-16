function __set_gsh() {
	GSH=true
	alias g='git logf'
	alias ga='git logfa'

	# Empty line when triggered from zle/key binding
	if zle; then echo; fi
	# Show git status when entering gsh
	git
}

function __unset_gsh() {
	unset GSH
	unalias g
	unalias ga
}

# git -> git status.
function git() {
	if [ -z "$1" ]; then
		env git status --short --branch
	elif [ "$@" = "r" ]; then
		r
	else
		env git "$@"
	fi
}

function gsh-list-choices() {
	if is_gsh && ([ "$INSTANT_REPL_PREFIX" = "$BUFFER" ] || [ "$INSTANT_REPL_PREFIX" = "$BUFFER " ]); then
		zle repl-clear
		BUFFER=
	else
		zle list-choices
	fi
}
zle -N gsh-list-choices

function is_gsh() {
	[ -n "$GSH" ]
}

function is_not_gsh() {
	[ -z "$GSH" ]
}

# Set gsh as command instead of shortcut
function gsh() {
	INSTANT_REPL_PREFIX='git '
	__set_gsh
}

# Start gsh if zsh is started in GSH mode
if is_gsh; then
	gsh
fi
