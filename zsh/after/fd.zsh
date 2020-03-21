if hash fdfind 2>/dev/null
then
	alias fd=fdfind
	alias '?'='fd'
elif hash fd 2>/dev/null
then
	alias '?'='fd'
else
	function ffind() {
		find . -iname "*$1*"
	}
	alias '?'='ffind'

	echo '[WARN] fd(-find) is not installed'
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
