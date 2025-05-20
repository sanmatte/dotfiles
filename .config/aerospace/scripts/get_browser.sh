#!/bin/bash

# move browser to current workspace
BROWSER_BUNDLE_ID="app.zen-browser.zen"
CURRENT_WORKSPACE=$(aerospace list-workspaces --focused)

# get browser window and workspace id
IFS='-' read -r BROWSER_ID BROWSER_WORKSPACE <<< "$(aerospace list-windows --monitor all --app-bundle-id "$BROWSER_BUNDLE_ID" --format '%{window-id}-%{workspace}')"

# if the browser is not in the current workspace, bring it; else send to workspace 2 
if [[ "$CURRENT_WORKSPACE" != "$BROWSER_WORKSPACE" ]]; then
    TARGET=$CURRENT_WORKSPACE
else
    TARGET=2
fi

aerospace move-node-to-workspace --window-id "$BROWSER_ID" "$TARGET"

