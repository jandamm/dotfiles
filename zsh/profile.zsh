# Shortcut to my dotfiles directory
export DOTFILES="$HOME/.dotfiles"
export DOTFILES_PRIVATE="$HOME/.pdotfiles"
export DOTFILES_CACHE="$HOME/.cache"
export DOTFILES_ZSH="$DOTFILES/zsh"

declare -A ZINIT
ZINIT[BIN_DIR]="$DOTFILES/zinit"
ZINIT[HOME_DIR]="$DOTFILES_CACHE/zsh/zinit"

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
