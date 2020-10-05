# Default options for fzf
# - Use reverse layout
# - Preview using bat or exa
# - Quit when no selection is possible
# - Select when only one selection is possible
# - Bind alt-n/j to move preview down
# - Bind alt-p/k to move preview up
# - Bind alt-w to wrap preview
# - Bind alt-z to hide preview
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS"'
--layout=reverse
--preview "([ -f {} ] && bat --color=always {}) || ([ -d {} ] && exa -G1 {}) || echo {}"
--exit-0
--select-1
--bind="˚:preview-up+preview-up+preview-up+preview-up+preview-up,π:preview-up"
--bind="∆:preview-down+preview-down+preview-down+preview-down+preview-down,˜:preview-down"
--bind="∑:toggle-preview-wrap"
--bind="Ω:toggle-preview"
'

# Use rg instead of find
# rg is configured to ignore files/paths I don't want to search.
export FZF_DEFAULT_COMMAND='rg --files --hidden'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
