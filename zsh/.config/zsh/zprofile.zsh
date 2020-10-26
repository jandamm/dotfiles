# Shortcut to my dotfiles directory
export DOTFILES="$HOME/.dotfiles"

export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"

path=(
	"$HOME/.local/bin"
	"/usr/local/opt/coreutils/libexec/gnubin"
	"/usr/local/opt/gnu-sed/libexec/gnubin"
	"/usr/local/Cellar/node/15.0.1/bin"
	$path
)

# Where I keep my projects
export PROJECTS="$HOME/Projects/"

if [ "$(uname -s)" = "Darwin" ]
then export ZSHRC_CONFIG_USER='MAC'
elif [ "$(whoami)" = 'openhabian' ]
then export ZSHRC_CONFIG_USER='HAPI'
fi
