INSTANT_REPL_HOOK_FILTER=equal_command

function __set_gsh() {
	GSH=true
	alias g='git logf'

	# Empty line when triggered from zle/key binding
	if zle; then echo; fi
	# Show git status when entering gsh
	git
}

function __unset_gsh() {
	unset GSH
	unalias g
}

function instant_repl_prefix_hook() {
	case $1 in
		git*) __unset_gsh; zle repl-redraw-prompt;;
	esac
	case $2 in
		git*) __set_gsh; zle repl-redraw-prompt;;
	esac
}

# git -> git status.
function git() {
	if [ -z "$1" ]; then
		env git status --short --branch
	else
		env git "$@"
	fi
}

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
