function __set_gsh() {
	GSH=true
	alias r='git logf'
	alias ra='git logfa'

	# Empty line when triggered from zle/key binding
	if zle; then echo; fi
	# Show git status when entering gsh
	git

	# TODO: Save all changes in a dictionary and restore them.
	# When there is another value, it should be worth it.
	if [ ! $PER_DIRECTORY_HISTORY_BASE_DEFAULT ]; then
		PER_DIRECTORY_HISTORY_BASE_DEFAULT=$PER_DIRECTORY_HISTORY_BASE
	fi
	PER_DIRECTORY_HISTORY_BASE="$DOTFILES_CACHE/gsh/history_dirs"
	_per-directory-history-change-directory
}

function __unset_gsh() {
	unset GSH
	unalias r
	unalias ra

	PER_DIRECTORY_HISTORY_BASE=$PER_DIRECTORY_HISTORY_BASE_DEFAULT
	unset PER_DIRECTORY_HISTORY_BASE_DEFAULT
	_per-directory-history-change-directory
}

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
