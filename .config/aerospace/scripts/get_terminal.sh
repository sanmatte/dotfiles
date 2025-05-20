#!/bin/bash

# move terminal to current workspace
ITERM_BUNDLE_ID="com.googlecode.iterm2"
CURRENT_WORKSPACE=$(aerospace list-workspaces --focused)

# get terminal and workspace id
IFS='-' read -r TERMINAL_ID TERMINAL_WORKSPACE <<< "$(aerospace list-windows --monitor all --app-bundle-id "$ITERM_BUNDLE_ID" --format '%{window-id}-%{workspace}')"

# if the terminal is not in the current workspace, bring it; else send to workspace 1
if [[ "$CURRENT_WORKSPACE" != "$TERMINAL_WORKSPACE" ]]; then
    TARGET=$CURRENT_WORKSPACE
else
    TARGET=1
fi

aerospace move-node-to-workspace --window-id "$TERMINAL_ID" "$TARGET"

