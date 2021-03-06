# Disable flow control to be able to bind ^s and ^q
# http://zsh.sourceforge.net/FAQ/zshfaq03.html
unsetopt flowcontrol

# Expand !gs to last command starting with gs
# ^gs to remove first 'gs' from last command
bindkey ' ' magic-space

# Fix backspace not working for existing text
# iarst<ESC>i<DEL> would result in "arst" not "ars"
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char

# Better vi-mode
bindkey -M vicmd '/' history-search-multi-word
bindkey -M vicmd 'U' redo

# Emacs bindings
bindkey '^a' beginning-of-line
bindkey '^b' backward-char
bindkey '^e' end-of-line
bindkey '^f' forward-char
bindkey '^u' repl-kill-whole-line-toggle
bindkey '^w' backward-delete-word

# Adapt list-choices for gsh
bindkey '^d' gsh-list-choices

# Use instant repl
bindkey '^s' repl-set

# Use control z to quickly foreground background job
bindkey '^z' fancy-ctrl-z

# Forward word bindings (for autosuggestion completion)
bindkey 'ƒ' vi-forward-word # Alt-F
bindkey '∫' backward-word # Alt-B

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
bindkey '^p' up-line-or-beginning-search

# [Ctrl+n] Search in History Down
bindkey '^n' down-line-or-beginning-search
