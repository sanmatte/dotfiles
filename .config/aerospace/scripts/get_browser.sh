#!/bin/bash

# move terminal to current workspace
TARGET=$(aerospace list-workspaces --focused)
aerospace workspace 2
aerospace move-node-to-workspace "$TARGET"
aerospace workspace "$TARGET"
