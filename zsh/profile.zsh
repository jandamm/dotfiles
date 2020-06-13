# Shortcut to my dotfiles directory
export DOTFILES="$HOME/.dotfiles"
export DOTFILES_PRIVATE="$HOME/.pdotfiles"
export DOTFILES_CACHE="$HOME/.cache"
export DOTFILES_ZSH="$DOTFILES/zsh"

path=(
	"$HOME/.bin"
	"$HOME/.rbenv/shims"
	$path
)

# Where I keep my projects
export PROJECTS="$HOME/Projects/"

if [ "$(uname -s)" = "Darwin" ]
then export ZSHRC_CONFIG_USER='MAC'
elif [ "$(whoami)" = 'openhabian' ]
then export ZSHRC_CONFIG_USER='HAPI'
fi

export COMPDUMPNAME="$HOME/.zsh/zcompdump_$ZSH_VERSION"
