# tmux-error-explain

A tmux plugin that automatically detects errors in your terminal output and explains them using AI assistance.

![Demo](https://via.placeholder.com/600x300/1a1a1a/ffffff?text=tmux-error-explain+demo)

## Features

- 🔍 **Automatic Error Detection**: Scans terminal output for error patterns
- 🤖 **AI-Powered Explanations**: Uses Claude Code to explain errors and suggest fixes
- ⚡ **Quick Access**: Single keybind to analyze the last command output
- 🎛️ **Configurable**: Customize keybindings and behavior
- 🪟 **Clean Interface**: Works with tmux-floax for floating window display

## Installation

### Prerequisites

**Required:**
- [tmux](https://github.com/tmux/tmux) (version 2.0+)
- [Claude Code CLI](https://claude.ai/code) with active subscription

**Recommended:**
- [tmux-floax](https://github.com/omerxx/tmux-floax) for floating window display
- [TPM (Tmux Plugin Manager)](https://github.com/tmux-plugins/tpm)

### Via TPM (Recommended)

1. Add to your `~/.tmux.conf`:
```bash
set -g @plugin 'yourusername/tmux-error-explain'
```

2. Install with TPM:
```bash
# Press prefix + I (default: Ctrl-b + I)
```

### Manual Installation

```bash
git clone https://github.com/yourusername/tmux-error-explain ~/.tmux/plugins/tmux-error-explain
```

Add to your `~/.tmux.conf`:
```bash
run-shell ~/.tmux/plugins/tmux-error-explain/error-explain.tmux
```

Reload tmux config:
```bash
tmux source-file ~/.tmux.conf
```

## Setup

### 1. Claude Code CLI Setup

Install Claude Code CLI and authenticate:
```bash
# Install via pip (requires Python 3.8+)
pip install claude-cli

# Or download from https://claude.ai/code
```

Ensure you have an active Claude subscription and the CLI is working:
```bash
claude -p "Hello world"
```

### 2. Optional: tmux-floax Setup

For the best experience, install tmux-floax for floating error explanations:
```bash
# Via TPM - add to ~/.tmux.conf:
set -g @plugin 'omerxx/tmux-floax'

# Then press prefix + I to install
```

## Usage

1. **Run any command** that might produce an error:
```bash
gcc missing-file.c
npm start
python script.py
```

2. **Press the error explain key** (default: `prefix + E`):
```bash
# Default: Ctrl-b + E
```

3. **Get instant AI analysis** of the error with suggested fixes!

## Configuration

### Keybinding

Change the default keybinding by adding to your `~/.tmux.conf`:
```bash
# Default is 'E' (so prefix + E)
set -g @error_explain_key 'F'  # Changes to prefix + F
```

### Output Mode

Choose between interactive and non-interactive modes:
```bash
# Non-interactive (default): Clean, fast output
set -g @error_explain_non_interactive '1'

# Interactive: Allows follow-up questions
set -g @error_explain_non_interactive '0'
```

## How It Works

1. **Error Detection**: Scans the last terminal output for common error patterns:
   - `error`, `failed`, `exception`, `panic`, `fatal`

2. **AI Analysis**: Sends the error context to Claude Code CLI with a specialized prompt

3. **Smart Display**: Shows the analysis in a floating window (with tmux-floax) or inline

4. **Cleanup**: Automatically manages temporary files and sessions

## Examples

### Compiler Errors
```bash
$ gcc hello.c
hello.c:5:1: error: expected ';' before '}' token
# Press prefix + E
# → Get explanation about missing semicolon and exact fix location
```

### Package Manager Errors
```bash
$ npm install
npm ERR! peer dep missing: react@>=16.8.0
# Press prefix + E  
# → Get explanation about peer dependencies and installation command
```

### Python Errors
```bash
$ python script.py
NameError: name 'varaible' is not defined
# Press prefix + E
# → Get explanation about typos and variable scope
```

## Troubleshooting

### Claude Code Not Found
```bash
# Check if Claude CLI is installed and in PATH
which claude
claude --version
```

### No Errors Detected
The plugin only triggers on text containing error keywords. For custom error patterns, you can modify the detection in `scripts/error-explain.sh`.

### Floax Not Working
The plugin works without tmux-floax but provides a better experience with it. Install tmux-floax or the plugin will fall back to inline display.

## Dependencies

### Required
- **tmux** 2.0+
- **Claude Code CLI** with active subscription
- **bash** (for shell scripts)

### Optional
- **tmux-floax** (for floating windows)
- **grep** (usually pre-installed)

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test with various error types
5. Submit a pull request

## License

MIT License - see LICENSE file for details.

## Support

- 🐛 **Issues**: [GitHub Issues](https://github.com/yourusername/tmux-error-explain/issues)
- 💡 **Feature Requests**: [GitHub Discussions](https://github.com/yourusername/tmux-error-explain/discussions)
- 📖 **Claude Code Help**: [Claude Code Documentation](https://claude.ai/code)

---

**Note**: This plugin requires a Claude subscription. The AI analysis happens locally through the Claude CLI, ensuring your code stays private while getting intelligent error explanations.