#!/bin/bash
# Get the currently focused workspace
current_workspace=$(aerospace list-workspaces --focused)

# List windows that are part of a "Picture-in-Picture" or "Picture in Picture" window
aerospace list-windows --all | grep -E "(Reminder)" | awk '{print $1}' | while read window_id; do

    # If a window ID is found, move it to the current workspace
    if [ -n "$window_id" ]; then
        aerospace move-node-to-workspace --window-id "$window_id" "$current_workspace"
    fi
done

