#!/bin/bash

# move terminal to current workspace
TARGET=$(aerospace list-workspaces --focused)
aerospace workspace 1
aerospace move-node-to-workspace "$TARGET"
aerospace workspace "$TARGET"
