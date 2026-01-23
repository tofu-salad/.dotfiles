#!/usr/bin/env bash

KS_PATHS=(~/Code ~/Code/Github ~/Diego/Code)
SESSION_DIR="$HOME/.local/share/kitty/sessions"
mkdir -p "$SESSION_DIR"

if ! command -v fzf &>/dev/null; then
    echo "fzf is required. Install it first."
    exit 1
fi

if ! command -v kitten &>/dev/null; then
    echo "kitty kitten is not available. Run this inside Kitty."
    exit 1
fi

# start or load a session
start_session() {
    # find existing session files
    SESSION_FILES=$(find "$SESSION_DIR" -name '*.kitty-session')
    SESSION_DIRS=$(echo "$SESSION_FILES" | while read -r session; do
        basename "${session%.*}"
    done)

    # find all project directories
    DIRS=$(find "${KS_PATHS[@]}" -mindepth 1 -maxdepth 1 -type d 2>/dev/null)

    # filter out dirs that already have a session
    if [[ -n "$SESSION_DIRS" ]]; then
        FILTERED_DIRS=$(echo "$DIRS" | grep -v -F -f <(echo "$SESSION_DIRS"))
        DISPLAY_SESSIONS=$(echo "$SESSION_DIRS" | while read -r session; do
            echo "[KITTY] $session"
        done)
    else
        FILTERED_DIRS="$DIRS"
        DISPLAY_SESSIONS=""
    fi

    # let the user pick a directory or existing session
    SELECTED=$({
        echo "${DISPLAY_SESSIONS}"
        echo "${FILTERED_DIRS}"
    } | fzf)

    [[ -z "$SELECTED" ]] && exit 0

    # if an existing session was selected
    if [[ "$SELECTED" == "[KITTY] "* ]]; then
        PROJECT_NAME="${SELECTED#\[KITTY\] }"
        SESSION_FILE="$SESSION_DIR/${PROJECT_NAME}.kitty-session"
        kitten @ action goto_session "$SESSION_FILE"

    # If a new project directory was selected
    else
        PROJECT_PATH="$SELECTED"
        PROJECT_NAME=$(basename "$PROJECT_PATH")
        SESSION_FILE="$SESSION_DIR/${PROJECT_NAME}.kitty-session"

        # generate session dynamically
        cat >"$SESSION_FILE" <<EOF
new_tab main
cd "$PROJECT_PATH"
launch
EOF
        kitten @ new_tab_with_cwd --cwd "$PROJECT_PATH" --title "$PROJECT_NAME" --tab-title "$PROJECT_NAME"
        kitten @ close_tab
        kitten @ action goto_session "$SESSION_FILE"
    fi
}
start_session
