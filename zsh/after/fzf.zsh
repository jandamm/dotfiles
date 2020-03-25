# Default options for fzf
# - Use reverse layout
# - Preview using bat or exa
# - Quit when no selection is possible
# - Select when only one selection is possible
export FZF_DEFAULT_OPTS='--layout=reverse --preview "([ -f {} ] && bat --color=always {}) || ([ -d {} ] && exa -G1 {}) || echo {} " -0 -1'

# Use rg instead of find
# rg is configured to ignore files/paths I don't want to search.
export FZF_DEFAULT_COMMAND='rg --files --hidden'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
