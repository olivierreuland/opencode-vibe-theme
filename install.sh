#!/bin/bash

# OpenCode Vibe Theme Installer
# Installs theme files to their appropriate locations

set -e

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Default values
FORCE=false
LINK=false

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -f|--force)
            FORCE=true
            shift
            ;;
        -l|--link)
            LINK=true
            shift
            ;;
        -h|--help)
            echo "OpenCode Vibe Theme Installer"
            echo ""
            echo "Usage: $0 [OPTIONS]"
            echo ""
            echo "Options:"
            echo "  -f, --force    Overwrite existing theme files"
            echo "  -l, --link     Use symbolic links instead of copying (useful for development)"
            echo "  -h, --help     Show this help message"
            echo ""
            echo "This script installs the OpenCode Vibe theme for:"
            echo "  - Zed editor (~/.config/zed/themes/)"
            echo "  - Ghostty terminal (~/.config/ghostty/themes/)"
            echo "  - OpenCode (~/.config/opencode/themes/)"
            echo ""
            echo "Note: This installer is designed for macOS and Linux systems."
            exit 0
            ;;
        *)
            echo -e "${RED}Error: Unknown option $1${NC}"
            echo "Use --help for usage information"
            exit 1
            ;;
    esac
done

# Get the directory where the script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo -e "${BLUE}OpenCode Vibe Theme Installer${NC}"
if [ "$LINK" = true ]; then
    echo -e "${YELLOW}Mode: Symbolic Links${NC}"
fi
echo ""

# Function to copy or link file with force check
copy_file() {
    local src="$1"
    local dest="$2"
    local name="$3"
    
    # Check if source file exists
    if [ ! -f "$src" ]; then
        echo -e "${RED}✗ Source file not found: $src${NC}"
        return 1
    fi
    
    # Create destination directory if it doesn't exist
    mkdir -p "$(dirname "$dest")"
    
    # Check if destination file exists
    if [ -f "$dest" ] || [ -L "$dest" ]; then
        if [ "$FORCE" = true ]; then
            rm -f "$dest"
            if [ "$LINK" = true ]; then
                ln -s "$src" "$dest"
                echo -e "${GREEN}✓ $name (linked, overwritten)${NC}"
            else
                cp "$src" "$dest"
                echo -e "${GREEN}✓ $name (copied, overwritten)${NC}"
            fi
        else
            # Check if we should replace a copy with a link
            if [ "$LINK" = true ] && [ ! -L "$dest" ]; then
                echo -e "${YELLOW}⊘ $name (already exists as file, use -f -l to overwrite with link)${NC}"
            else
                echo -e "${YELLOW}⊘ $name (already exists, use -f to overwrite)${NC}"
            fi
        fi
    else
        if [ "$LINK" = true ]; then
            ln -s "$src" "$dest"
            echo -e "${GREEN}✓ $name (linked)${NC}"
        else
            cp "$src" "$dest"
            echo -e "${GREEN}✓ $name (copied)${NC}"
        fi
    fi
}

# Install Zed theme
echo -e "${BLUE}Installing Zed theme...${NC}"
copy_file \
    "$SCRIPT_DIR/themes/zed/opencode-vibe.json" \
    "$HOME/.config/zed/themes/opencode-vibe.json" \
    "Zed theme"

# Install Ghostty themes
echo ""
echo -e "${BLUE}Installing Ghostty themes...${NC}"
copy_file \
    "$SCRIPT_DIR/themes/ghostty/opencode-vibe" \
    "$HOME/.config/ghostty/themes/opencode-vibe" \
    "Ghostty theme (dark)"
copy_file \
    "$SCRIPT_DIR/themes/ghostty/opencode-vibe-light" \
    "$HOME/.config/ghostty/themes/opencode-vibe-light" \
    "Ghostty theme (light)"

# Install OpenCode theme
echo ""
echo -e "${BLUE}Installing OpenCode theme...${NC}"
copy_file \
    "$SCRIPT_DIR/themes/opencode/opencode-vibe.json" \
    "$HOME/.config/opencode/themes/opencode-vibe.json" \
    "OpenCode theme"

echo ""
echo -e "${GREEN}Installation complete!${NC}"
echo ""
echo "Next steps:"
echo ""
echo -e "${BLUE}Zed:${NC}"
echo "  - Press Cmd+K then Cmd+T (or Ctrl+K then Ctrl+T on Linux)"
echo "  - Search for 'OpenCode Vibe' and select it"
echo "  Or add to ~/.config/zed/settings.json:"
echo '    { "theme": "OpenCode Vibe" }'
echo ""
echo -e "${BLUE}Ghostty:${NC}"
echo "  - Add to ~/.config/ghostty/config:"
echo "    theme = opencode-vibe           # for dark theme"
echo "    theme = opencode-vibe-light     # for light theme"
echo "  - Restart Ghostty or reload configuration"
echo ""
echo -e "${BLUE}OpenCode:${NC}"
echo "  - Add to ~/.config/opencode/opencode.json:"
echo '    { "theme": "opencode-vibe" }'
echo ""
