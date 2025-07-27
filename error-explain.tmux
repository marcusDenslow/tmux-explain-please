#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Set default key binding
error_explain_key=$(tmux show-option -gqv "@error_explain_key")
error_explain_key=${error_explain_key:-"E"}

# Bind the key to run error explanation
tmux bind-key "$error_explain_key" run-shell "$CURRENT_DIR/scripts/error-explain.sh"