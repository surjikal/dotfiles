
# parent_process_name=$(ps -o comm= $PPID)
# if [[ "$TERM_PROGRAM" != vscode ]]; then
#     plugins+=(pipenv)
# fi

is_installed nano && export EDITOR="nano"

# subl
export PATH="/Applications/Sublime Text.app/Contents/SharedSupport/bin:$PATH"

# vscode
export PATH="$PATH:/Applications/Visual Studio Code - Insiders.app/Contents/Resources/app/bin"
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
