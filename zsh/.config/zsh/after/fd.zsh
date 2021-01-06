if hash fdfind 2>/dev/null; then
	alias fd=fdfind
fi

alias fzfbat='fzf --preview "bat --color=always {}"'

function ff() {
	fd "$1" | fzf
}

# Fuzzy find directories
function ffd() {
	fd -t d "$1" | fzf
}

# Fuzzy find files
function fff() {
	fd -t f "$1" | fzfbat
}
