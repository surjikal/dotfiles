#!/usr/bin/env zsh

export DAILY_DIR="${DAILY_DIR:-${HOME}/dev/daily}"

function daily_timestamp {
    date +'%Y-%m-%d'
}

function daily {
    local filename="$(daily_timestamp).log"
    local filepath="${DAILY_DIR}/${filename}.md"

    mkdir -p $(dirname "${filepath}")

    # if file doesn't exist
    if [[ ! -e "${filepath}" ]]; then
        echo "# $(daily_timestamp)" > "${filepath}"
    fi

    $EDITOR +2 "${filepath}"
}

function daily-list {
    find $(pwd) -type f -not -path '*/\.*' | sort -r
}

function daily-edit {
    local filepath=$(find $(pwd) -type f -not -path '*/\.*' | sort | fzf)
    $EDITOR "${filepath}"
}
