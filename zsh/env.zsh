# Shortcut to my dotfiles directory
export DOTFILES="$HOME/.dotfiles"
export DOTFILES_PRIVATE="$HOME/.pdotfiles"
export DOTFILES_CACHE="$HOME/.cache"
export DOTFILES_ZSH="$DOTFILES/zsh"

declare -A ZINIT
ZINIT[BIN_DIR]="$DOTFILES/zinit"
ZINIT[HOME_DIR]="$DOTFILES_CACHE/zsh/zinit"

export GEM_HOME=$HOME/.gem

path=(
	"$HOME/.bin"
	"$HOME/.emacs.d/bin"
	"$GEM_HOME/bin"
	"/usr/local/bin"
	"/usr/local/sbin"
	"/bin"
	"/sbin"
	$path
)

# Where I keep my projects
export PROJECTS="$HOME/Projects/"

if [ "$(uname -s)" = "Darwin" ]
then export ZSHRC_CONFIG_USER='MAC'
elif [ "$(whoami)" = 'openhabian' ]
then export ZSHRC_CONFIG_USER='HAPI'
fi
