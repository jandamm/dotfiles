# Make sure that the terminal is in application mode when zle is active, since
# only then values from $terminfo are valid
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
	function zle-line-init() {
		echoti smkx
	}

	function zle-line-finish() {
		echoti rmkx
	}

	zle -N zle-line-init
	zle -N zle-line-finish
fi

# [Ctrl+p] Search in History Up
autoload -U up-line-or-beginning-search
zle -N up-line-or-beginning-search

# [Ctrl+n] Search in History Down
autoload -U down-line-or-beginning-search
zle -N down-line-or-beginning-search
