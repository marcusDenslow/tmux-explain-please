#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Set default key binding
error_explain_key=$(tmux show-option -gqv "@error_explain_key")
error_explain_key=${error_explain_key:-"E"}

# Set default non-interactive mode (1 = fast/clean output, 0 = interactive for follow-ups)
non_interactive_default=$(tmux show-option -gqv "@error_explain_non_interactive")
if [ -z "$non_interactive_default" ]; then
    tmux set-option -g "@error_explain_non_interactive" "1"
fi

# Bind the key to run error explanation
tmux bind-key "$error_explain_key" run-shell "$CURRENT_DIR/scripts/error-explain.sh"