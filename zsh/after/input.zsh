# Expand !gs to last command starting with gs
# ^gs to remove first 'gs' from last command
bindkey ' ' magic-space

# Fix backspace not working for existing text
# iarst<ESC>i<DEL> would result in "arst" not "ars"
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char

# Emacs bindings
bindkey '^a' beginning-of-line
bindkey '^b' backward-char
bindkey '^e' end-of-line
bindkey '^f' forward-char
bindkey '^u' backward-kill-line
bindkey '^w' backward-delete-word

# Forward word bindings (for auttosuggestion completion
bindkey 'ƒ' vi-forward-word # Alt-F
bindkey '∫' backward-word # Alt-B

# History

# FZF History Search
bindkey '^s' fzf-history-widget

# [Shift-Tab] - move through the completion menu backwards
if [[ "${terminfo[kcbt]}" != "" ]]; then
  bindkey "${terminfo[kcbt]}" reverse-menu-complete
fi

# [Up-Arrow] - Up a line of history
if [[ "${terminfo[kcuu1]}" != "" ]]; then
  bindkey "${terminfo[kcuu1]}" up-line-or-history
fi

# [Down-Arrow] - Down a line of history
if [[ "${terminfo[kcud1]}" != "" ]]; then
  bindkey "${terminfo[kcud1]}" down-line-or-history
fi

# [Ctrl+p] Search in History Up
autoload -U up-line-or-beginning-search
zle -N up-line-or-beginning-search
bindkey '^p' up-line-or-beginning-search

# [Ctrl+n] Search in History Down
autoload -U down-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^n' down-line-or-beginning-search
