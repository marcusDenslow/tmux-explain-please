#!/usr/bin/env bash

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}tmux-explain-please Installation${NC}"
echo "=================================="
echo

# Check if tmux is installed
if ! command -v tmux &> /dev/null; then
    echo -e "${RED}Error: tmux is not installed!${NC}"
    echo "Please install tmux first:"
    echo "  Ubuntu/Debian: sudo apt install tmux"
    echo "  macOS: brew install tmux" 
    echo "  Arch: sudo pacman -S tmux"
    exit 1
fi

echo -e "${GREEN}✓${NC} tmux found"

# Check if Claude CLI is installed
if ! command -v claude &> /dev/null; then
    echo -e "${YELLOW}Warning: Claude CLI not found${NC}"
    echo "You'll need to install it for the plugin to work:"
    echo "  Visit: https://claude.ai/code"
    echo "  Or: pip install claude-cli"
    echo
else
    echo -e "${GREEN}✓${NC} Claude CLI found"
fi

# Check if TPM is installed
if [ -d "$HOME/.tmux/plugins/tpm" ]; then
    echo -e "${GREEN}✓${NC} TPM found"
    
    # Check if already in tmux.conf
    if grep -q "tmux-explain-please" "$HOME/.tmux.conf" 2>/dev/null; then
        echo -e "${GREEN}✓${NC} Plugin already configured in tmux.conf"
    else
        echo -e "${YELLOW}Adding plugin to tmux.conf...${NC}"
        echo "" >> "$HOME/.tmux.conf"
        echo "# Error explanation plugin" >> "$HOME/.tmux.conf"
        echo "set -g @plugin 'yourusername/tmux-explain-please'" >> "$HOME/.tmux.conf"
        echo -e "${GREEN}✓${NC} Added to tmux.conf"
        echo -e "${BLUE}Note:${NC} Replace 'yourusername' with your actual GitHub username"
    fi
else
    echo -e "${YELLOW}TPM not found. Manual installation:${NC}"
    echo "1. Add this to your ~/.tmux.conf:"
    echo "   run-shell ~/.tmux/plugins/tmux-explain-please/error-explain.tmux"
    echo "2. Reload tmux: tmux source-file ~/.tmux.conf"
fi

# Check for recommended plugins
if [ -d "$HOME/.tmux/plugins/tmux-floax" ]; then
    echo -e "${GREEN}✓${NC} tmux-floax found (recommended)"
else
    echo -e "${YELLOW}Recommendation:${NC} Install tmux-floax for better UX:"
    echo "  Add to tmux.conf: set -g @plugin 'omerxx/tmux-floax'"
fi

echo
echo -e "${GREEN}Installation complete!${NC}"
echo
echo "Usage:"
echo "  1. Run a command that produces an error"
echo "  2. Press prefix + E (default: Ctrl-b + E)"
echo "  3. Get AI-powered error explanation!"
echo
echo "Configuration options:"
echo "  set -g @error_explain_key 'F'              # Change keybind"
echo "  set -g @error_explain_non_interactive '0'  # Enable interactive mode"
echo