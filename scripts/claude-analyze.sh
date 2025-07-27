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
- Keep the fix suggestion practical and specific to this error type"

# Call Claude Code with the error analysis prompt
echo "Analyzing error with Claude..."
echo "=================================="
echo ""

# Create a temporary file with the prompt
temp_prompt=$(mktemp)
echo "$prompt" > "$temp_prompt"

# Use claude code to analyze the error
claude code < "$temp_prompt"

echo ""
echo "=================================="
echo "Press 'q' to close floax or any other key to keep it open..."
read -n 1

# Clean up temp files
rm -f "$error_file" "$temp_prompt"