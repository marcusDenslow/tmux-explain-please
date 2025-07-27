#!/usr/bin/env bash

error_file="$1"

if [ ! -f "$error_file" ]; then
	echo "Error: No error file provided"
	exit 1
fi

# Read the error content
error_content=$(cat "$error_file")

# Extract the main compiler error (first line with "error:")
main_error=$(echo "$error_content" | grep -m1 "error:" | sed 's/^[[:space:]]*//')

# Create a prompt for Claude focusing on the fix suggestion
prompt="Analyze this compiler/build error and provide a fix suggestion. Use this EXACT format:

COMPILER ERROR: $main_error


--note:
[your short 1-2 line fix suggestion here]

Full error context:
$error_content

IMPORTANT: 
- This could be any type of error (syntax, missing imports, type mismatches, etc.)
- Use the EXACT error message '$main_error' after 'COMPILER ERROR:'
- Follow the exact formatting with 2 blank lines before '--note:' and 1 blank line after
- Keep the fix suggestion practical and specific to this error type
- DO NOT show any intermediate steps, file reads, searches, or thinking process
- ONLY output the final formatted response starting with 'COMPILER ERROR:'"

# Check if non-interactive mode is enabled (default: 1)
non_interactive=$(tmux show-option -gqv "@error_explain_non_interactive")
non_interactive=${non_interactive:-"1"}

# Call Claude with appropriate mode
echo "Analyzing error with Claude..."
echo "=================================="
echo ""

if [ "$non_interactive" = "1" ]; then
	# Use claude -p for clean, non-interactive output
	claude -p "$prompt"

	echo ""
	echo "=================================="
	echo "Press any key to return to tmux Floax"
	read -n 1
else
	# Use interactive mode for follow-up questions
	temp_prompt=$(mktemp)
	echo "$prompt" >"$temp_prompt"
	claude code <"$temp_prompt"
	rm -f "$temp_prompt"
fi

# Clean up temp file
rm -f "$error_file"
