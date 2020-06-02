# Measure startup and disable instant prompt
# ZSHRC_CONFIG_DIAG=1

# Instant Prompt and Diagnose {{{

if [[ $ZSHRC_CONFIG_DIAG -eq 1 ]]
then
	typeset -g ZPLG_MOD_DEBUG=1
	# If an error occurs probably this needs to be executed: `zinit module build`
	module_path+=( "$DOTFILES/zinit/zmodules/Src" )
	zmodload zdharma/zplugin
	zmodload zsh/zprof
	alias diagzinit="zpmod source-study | sort -r"
	alias diagzprof=zprof
	alias diag="diagzinit && diagzprof"

	# No instant prompt with gsh, as gsh is expected to print before first prompt.
elif [[ -r "${XDG_CACHE_HOME:-$DOTFILES_CACHE}/p10k-instant-prompt-${(%):-%n}.zsh" ]] && [ -z "$GSH" ]
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
export MANPAGER='less -s -M +Gg'

fpath=("$HOME/.zsh/completions" $fpath)

# adds @(|) *(|) ?(|) +(|) which translate to regex: (|) (|)* (|)? (|)+
setopt extendedglob

# This is required by some tools like tmux and fastlane.
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Load and recompile before plugins
setopt nullglob
for file in $HOME/.zsh/before/*.zsh
do
	source "$file"
done
unsetopt nullglob

source $HOME/.zsh/zinit.zsh

# Load plugins {{{

# Appearance {{{

# base16-theme
zinit snippet https://github.com/chriskempson/base16-shell/tree/master/scripts/base16-onedark.sh
zinit snippet https://github.com/nicodebo/base16-fzf/blob/master/bash/base16-onedark.config

# Prompt theme
zinit ice depth=1
zinit light romkatv/powerlevel10k

# Show line cursor in vi mode
zinit light jandamm/vi-mode.zsh

# Colors in man pages
zinit light ael-code/zsh-colored-man-pages

# }}}

# Commands {{{

zinit ice as'program'
zinit snippet https://github.com/raylee/tldr/blob/master/tldr

zinit ice as'program' pick'fasd'
zinit light clvv/fasd

zinit ice as'program' pick'bin/git-dsf'
zinit light zdharma/zsh-diff-so-fancy

# }}}

# Completion {{{

# Tab completion is working with fzf
zinit light Aloxaf/fzf-tab

# Load more completions
zinit ice blockf atpull'zinit creinstall -q .'
zinit light zsh-users/zsh-completions

# Load completion for zinit
zinit ice as'completion'
zinit light $ZINIT[BIN_DIR]

# Load completion for git flow
zinit light petervanderdoes/git-flow-completion

# }}}

# FZF
# **TAB to completion options in fzf (not 100% working with fzf-tab, still better than without)
zinit snippet https://github.com/junegunn/fzf/blob/master/shell/completion.zsh
# ^t to list all files from ./ in fzf
zinit snippet https://github.com/junegunn/fzf/blob/master/shell/key-bindings.zsh

# History is saved per directory
zinit light jandamm/per-directory-history

# History search with syntax highlighting
zinit light zdharma/history-search-multi-word

# Quickly create a repl for the current BUFFER
zinit light jandamm/instant-repl.zsh

# Use system clipboard with zsh and sync with tmux
typeset -g ZSH_SYSTEM_CLIPBOARD_TMUX_SUPPORT='true'
zinit light kutsan/zsh-system-clipboard

# }}}

# Load and recompile after plugins
setopt nullglob
for file in $HOME/.zsh/after/*.zsh
do
	source "$file"
done
unsetopt nullglob

# Completion {{{

# Initialize zsh completion
# zcompdump is named .zsh to be compiled as well.
# Always use cached version. Recreating is done in zlogin. (Should only dump if there is no file)
autoload -Uz compinit && compinit -i -C -d "$HOME/.zsh/zcompdump_$ZSH_VERSION.zsh"

# load bash completion
# autoload bashcompinit && bashcompinit
# source file/to/bash/completion.sh

# Load completions for gems
source /usr/local/Cellar/rbenv/*/completions/rbenv.zsh

# Define completions for command options
# Commands with gnu style '--help' can be added here.
compdef _gnu_generic \
	bat \
	fasd fd fzf \
	pod \
	swiftformat \
	xed

compdef g=git

# }}}

# Post Completion Plugins {{{

# Here syntax highlighting is loaded before autosuggestions
# (By the author of fast-syntax-highlighting)
# https://zdharma.org/zinit/wiki/Example-Minimal-Setup/
zinit light zdharma/fast-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions

# Change style of global aliases
FAST_HIGHLIGHT_STYLES[global-alias]=fg=green,bold,underline

# Add compdef from plugins
zinit cdreplay -q

# }}}

# vim: set foldmethod=marker:
