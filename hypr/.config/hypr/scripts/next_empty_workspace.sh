#!/bin/bash

# Get list of all active workspaces
active_workspaces=$(hyprctl workspaces -j | jq '.[].id')

# Check workspaces 1–10
for i in {1..10}; do
    if ! echo "$active_workspaces" | grep -q -w "$i"; then
        hyprctl dispatch workspace "$i"
        exit
    fi
done
