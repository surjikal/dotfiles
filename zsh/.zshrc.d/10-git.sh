
# Fixes graphical issues with git-gui / gitk
TK_HOME=$(brew --prefix tcl-tk 2> /dev/null)
[[ -d $TK_HOME ]] || export PATH="/usr/local/opt/tcl-tk/bin:$PATH"

# git
alias gg="git gui"
alias gk="gitk --all"
alias gs="git status --untracked-files=no --short"
