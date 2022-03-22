# Measure startup and disable instant prompt
# ZSHRC_CONFIG_DIAG=1

# Save initial TERM and COLORTERM
# This code is needed for nvim to have the correct values set.
[ -z $INIT_TERM ] && export INIT_TERM=$TERM
[ -z $INIT_COLORTERM ] && export INIT_COLORTERM=$COLORTERM
export TERM=$INIT_TERM
export COLORTERM=$INIT_COLORTERM

# Instant Prompt and Diagnose {{{

if [[ $ZSHRC_CONFIG_DIAG -eq 1 ]]
then
	zmodload zsh/zprof
	alias diag=zprof

	# No instant prompt with gsh, as gsh is expected to print before first prompt.
elif [[ -r "$XDG_CACHE_HOME/zsh/p10k-instant-prompt-${(%):-%n}.zsh" ]] && [ -z "$GSH" ]
then
	source "$XDG_CACHE_HOME/zsh/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# }}}

# History {{{

export HISTFILE="$XDG_DATA_HOME/zsh/zsh_history"
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
PER_DIRECTORY_HISTORY_BASE="$XDG_DATA_HOME/zsh/history_dirs"

# }}}

# Settings
[ -u $EDITOR ] && export EDITOR=nvim
[ -u $VISUAL ] && export VISUAL=nvim
export MANPAGER='less -s -M +Gg'

fpath=("$ZDOTDIR/functions" $fpath)

# adds @(|) *(|) ?(|) +(|) which translate to regex: (|) (|)* (|)? (|)+
setopt extendedglob

# automatically cd into a folder by just providing a path
setopt autocd

# Use same characters for words like vi
export WORDCHARS='@_'

# This is required by some tools like fastlane.
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Add zmv to use pattern to rename files
autoload -Uz zmv

# Load before plugins
setopt nullglob
for file in $ZDOTDIR/before/*.zsh
do
	source "$file"
done
unsetopt nullglob

ZGEN_COMPINIT_FLAGS='-i'
ZGEN_CUSTOM_COMPDUMP="$XDG_DATA_HOME/zsh/zcompdump_$ZSH_VERSION"
source $XDG_DATA_HOME/zgenom/zgenom.zsh

zgenom autoupdate

# Load plugins {{{

if ! zgenom saved
then
	zgenom compdef

	zgenom load jandamm/zgenom-ext-eval
	zgenom load jandamm/zgenom-ext-run

	zgenom load fnune/base16-fzf bash/base16-nord.config # base16-theme
	zgenom load romkatv/powerlevel10k powerlevel10k # Prompt theme
	zgenom load jandamm/vi-mode.zsh # Show line cursor in vi mode

	zgenom clone skywind3000/z.lua
	zgenom eval "$(lua $(zgenom api clone_dir skywind3000/z.lua)/z.lua --init zsh enhanced)"

	zgenom load mattmc3/zman

	zgenom load jandamm/git-pr
	zgenom load tj/git-extras etc/git-extras-completion.zsh
	zgenom run tj/git-extras PREFIX=$ZPFX/git-extras make
	zgenom bin $ZPFX/git-extras/bin --glob '^git-pr'

	zgenom load zsh-users/zsh-completions # Load more completions

	zgenom load junegunn/fzf shell/completion.zsh # **TAB to completion options in fzf
	zgenom load junegunn/fzf shell/key-bindings.zsh # ^t to list all files from ./ in fzf

	zgenom load jandamm/per-directory-history # History is saved per directory

	zgenom load zdharma-continuum/history-search-multi-word # History search with syntax highlighting

	zgenom load jandamm/instant-repl.zsh # Quickly create a repl for the current BUFFER

	zgenom load jandamm/nvim-shell

	zgenom load zdharma-continuum/fast-syntax-highlighting
	zgenom load zsh-users/zsh-autosuggestions

	zgenom save

	rbenv rehash

	zgenom compile "$HOME/.zshenv"
	zgenom compile "$XDG_CONFIG_HOME/zsh"
	zgenom compile "$XDG_DATA_HOME/zsh/generated"
fi
# }}}

# Load generated plugins
setopt nullglob
for file in $XDG_DATA_HOME/zsh/generated/*.zsh
do
	source "$file"
done

# Load after plugins
for file in $ZDOTDIR/after/*.zsh
do
	source "$file"
done
unsetopt nullglob

# Completion {{{

# load bash completion
# autoload bashcompinit && bashcompinit
# source file/to/bash/completion.sh

# Define completions for command options
# Commands with gnu style '--help' can be added here.
compdef _gnu_generic \
	ack aria2c \
	bat \
	fd fzf \
	ksdiff \
	pod \
	swiftformat \
	xcpretty xed

compdef g=git
compdef v=_zlua

# }}}

# Change style of global aliases
FAST_HIGHLIGHT_STYLES[global-alias]=fg=green,bold,underline

# }}}

# vim: set foldmethod=marker:
