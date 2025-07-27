#!/usr/bin/env bash

# Get the last command output from tmux history
get_last_command_output() {
    # Capture the last screen of output from current pane
    tmux capture-pane -p
}

# Main function
main() {
    # Get the output
    local output=$(get_last_command_output)
    
    # Check if output looks like it contains errors
    if echo "$output" | grep -qi "error\|failed\|exception\|panic\|fatal"; then
        # Create a temporary file for the error
        local temp_file=$(mktemp)
        echo "$output" > "$temp_file"
        
        # Check if tmux-floax is available
        if tmux list-commands | grep -q "run-shell.*floax" || [ -f "$HOME/.tmux/plugins/tmux-floax/scripts/floax.sh" ]; then
            # Use floax for floating window display
            cat > /tmp/claude_error_cmd.txt << EOF
bash $HOME/.tmux/plugins/tmux-error-explain/scripts/claude-analyze.sh $temp_file
EOF
            
            # Open floax first
            tmux run-shell "$HOME/.tmux/plugins/tmux-floax/scripts/floax.sh" &
            
            # Wait and then send commands to the scratch session that floax creates
            sleep 1
            tmux send-keys -t scratch: C-c
            sleep 0.1  
            tmux send-keys -t scratch: C-c
            sleep 0.1
            tmux send-keys -t scratch: C-l
            tmux send-keys -t scratch: "$(cat /tmp/claude_error_cmd.txt)" Enter
            rm /tmp/claude_error_cmd.txt
        else
            # Fallback: create a new tmux window for error analysis
            tmux new-window -n "Error-Explain" "bash $HOME/.tmux/plugins/tmux-error-explain/scripts/claude-analyze.sh $temp_file"
        fi
    else
        tmux display-message "No error detected in last output"
    fi
}

main "$@"