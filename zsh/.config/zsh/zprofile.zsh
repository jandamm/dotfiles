# Shortcut to my dotfiles directory
export DOTFILES="$HOME/.dotfiles"

export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"

path=(
	"$HOME/.local/bin"
	"/usr/local/Cellar/node/15.0.1/bin"
	$path
	"/usr/local/sbin"
)

fpath=(
	"$XDG_DATA_HOME/zsh/generated/functions"
	$fpath
)
