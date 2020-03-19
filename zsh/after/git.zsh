alias gcod='git checkout develop'
alias gcom='git checkout master'

alias gcm='git commit -m'

alias gcwip='git commit --no-verify -m "--wip-- [skip ci]"'

alias gds='git diff --staged'

alias gbD='git branch -D'

alias gbp='git branch | rg -i "^\* " | sed -e "s/^\* //"'
alias gbcp='gbp | tr -d "\n" | pbcopy'

alias gcor='gcof "release/"'
alias gcoh='gcof "hotfix/"'

alias gmd='git merge develop'
alias gmm='git merge master'

alias gmc='git merge --continue'

alias grp='git reset --patch'
alias grhhh='git add . && git reset --hard'

gcof() {
    b=$(git branch | rg -i "$1" | sed -e 's/^[ \t\*]*//')
    git checkout "$b"
}

gcot() {
    b=$(git branch | rg -i "[a-zA-Z]+/$1*" | sed -e 's/^[ \t\*]*//')
    git checkout "$b"
}

gbdf() {
    b=$(git branch | rg -i "$1" | sed -e 's/^[ \t\*]*//')
    git branch -d "$b"
}

# Git Flow
alias gfl="git flow"
alias gflc="git flow config"

alias gflf="git flow feature"
alias gflfs="git flow feature start"
alias gflff="git flow feature finish --no-ff"

alias gflb="git flow bugfix"
alias gflbs="git flow bugfix start"
alias gflbf="git flow bugfix finish --no-ff"

alias gflh="git flow hotfix"
alias gflhs="git flow hotfix start"
alias gflhf="git flow hotfix finish --no-ff"

alias gflr="git flow release"
alias gflrs="git flow release start"
alias gflrf="git flow release finish --no-ff"

alias gdtr='git diff-tree --no-commit-id --name-only -r'

alias gdt='git difftool'
alias gdts='git difftool --staged'

alias gdk='git difftool -y -t Kaleidoscope'
alias gdkca='git difftool -y -t Kaleidoscope --cached'
alias gdks='git difftool -y -t Kaleidoscope --staged'
