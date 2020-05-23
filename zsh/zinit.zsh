# This is outsourced to be able to update zinit in dotfile-setup

# Initialize zinit
declare -A ZINIT
ZINIT[BIN_DIR]="$DOTFILES/zinit"
ZINIT[HOME_DIR]="$DOTFILES_CACHE/zsh/zinit"

source "$DOTFILES/zinit/zinit.zsh"
