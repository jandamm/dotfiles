# Measure startup and disable instant prompt
#ZSHRC_CONFIG_DIAG=1

# Instant Prompt and Diagnose {{{

if [[ $ZSHRC_CONFIG_DIAG -eq 1 ]]
then
	typeset -g ZPLG_MOD_DEBUG=1
	module_path+=( "$DOTFILES/zinit/zmodules/Src" ) && zmodload zdharma/zplugin
	alias diag="zpmod source-study"

elif [[ -r "${XDG_CACHE_HOME:-$DOTFILES_CACHE}/p10k-instant-prompt-${(%):-%n}.zsh" ]]
then
	source "${XDG_CACHE_HOME:-$DOTFILES_CACHE}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# }}}

# History {{{

export HISTFILE="$DOTFILES_CACHE/zsh/zsh_history"
export HISTSIZE=10000
export HISTFILESIZE=${HISTSIZE}

# http://zsh.sourceforge.net/Doc/Release/Options.html#History
setopt histignorealldups  # no duplicates
setopt histignorespace    # no commands starting with space
setopt histsavenodups     # don't save duplicates
setopt histreduceblanks   # remove all unneccesary spaces
setopt sharehistory       # share history between sessions*
# * a new prompt has to be generated to sync.
# works only in same dir or global history.

PER_DIRECTORY_HISTORY_TOGGLE='^g'
PER_DIRECTORY_HISTORY_NEW_PROMPT=false
PER_DIRECTORY_HISTORY_BASE="$DOTFILES_CACHE/zsh/history_dirs"

# }}}

# Settings
export EDITOR=nvim
export LESS='-M +Gg'
export MANPAGER='less -s -M +Gg'

# This fixes an issue with $TMUX and Nerd Font
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

typeset -g ZSH_SYSTEM_CLIPBOARD_TMUX_SUPPORT='true'

for file in $HOME/.zsh/before/*.zsh
do
	source "$file"
done

source "$DOTFILES/zinit/zinit.zsh"

# Load plugins {{{

# Apps
if ! hash xcpretty &> /dev/null; then
	zinit ice pick"bin/xcpretty" as"program"
	zinit light xcpretty/xcpretty
fi
zinit snippet OMZ::plugins/dash/dash.plugin.zsh

function fg-fzf() {
	job="$(jobs | fzf -0 -1 | sed -E 's/\[(.+)\].*/\1/')" && echo '' && fg %$job
}
# https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/fancy-ctrl-z/fancy-ctrl-z.plugin.zsh
function fancy-ctrl-z () {
	if [[ $#BUFFER -eq 0 ]]; then
		BUFFER=" fg-fzf"
		zle accept-line -w
	else
		zle push-input -w
		zle clear-screen -w
	fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

zinit light Tarrasch/zsh-bd
zinit ice as"program"
zinit snippet https://github.com/raylee/tldr/blob/master/tldr

zinit light kutsan/zsh-system-clipboard

zinit ice pick"fasd" as"program"
zinit light clvv/fasd
eval "$(fasd --init zsh-hook)" # TODO capture in script and source.

# FZF
# **TAB to completion options in fzf
zinit snippet https://github.com/junegunn/fzf/blob/master/shell/completion.zsh
zinit snippet https://github.com/junegunn/fzf/blob/master/shell/key-bindings.zsh
zinit snippet https://github.com/nicodebo/base16-fzf/blob/master/bash/base16-onedark.config
zinit ice pick"fzf-tmux" as"program"
zinit snippet https://github.com/junegunn/fzf/blob/master/bin/fzf-tmux

# Git
zinit ice as"program" pick"bin/git-dsf"
zinit light zdharma/zsh-diff-so-fancy

zinit snippet OMZ::lib/git.zsh
zinit snippet OMZ::plugins/git/git.plugin.zsh
export FORGIT_FZF_DEFAULT_OPTS="
--bind='˚:preview-up,π:preview-up'
--bind='∆:preview-down,˜:preview-down'
--bind='∑:toggle-preview-wrap'
--reverse
"
zinit light wfxr/forgit
unalias ga
function ga {
	if [ -e "$1" ]
	then git add "$@"
	else forgit::add "$@"
	fi
}
unalias grh
function grh {
	if [ -e "$1" ]
	then git reset "$@"
	else forgit::reset::head "$@"
	fi
}
# Prompt
zinit ice depth=1
zinit light romkatv/powerlevel10k
zinit light woefe/vi-mode.zsh

# History per directory
zinit light jandamm/per-directory-history
zinit light zdharma/history-search-multi-word

# Completion
# zinit snippet OMZ::lib/completion.zsh
# fzf-tab must be sourced before autosuggestions and syntax-highlighting
zinit light Aloxaf/fzf-tab
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light petervanderdoes/git-flow-completion
zinit ice as'completion'
zinit snippet https://github.com/zdharma/zinit/raw/master/_zinit

# vim
zinit ice pick'bin/abolisher' as'program'
zinit snippet https://github.com/jandamm/abolisher/blob/master/bin/abolisher

# Coloring
zinit snippet https://github.com/chriskempson/base16-shell/tree/master/scripts/base16-onedark.sh
zinit load ael-code/zsh-colored-man-pages

# }}}

for file in $HOME/.zsh/after/*.zsh
do
	source "$file"
done

zinit light zdharma/fast-syntax-highlighting

# Compinit
autoload -Uz compinit; compinit
zinit cdreplay -q

# vim: set foldmethod=marker:
