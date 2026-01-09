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
INSTALL_ZED=true
INSTALL_GHOSTTY=true
INSTALL_VSCODE=true
INSTALL_OPENCODE=true

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
        --only)
            # Disable all by default when using --only
            INSTALL_ZED=false
            INSTALL_GHOSTTY=false
            INSTALL_VSCODE=false
            INSTALL_OPENCODE=false
            
            # Parse comma-separated list of applications
            IFS=',' read -ra APPS <<< "$2"
            for app in "${APPS[@]}"; do
                app=$(echo "$app" | tr '[:upper:]' '[:lower:]' | xargs) # lowercase and trim
                case $app in
                    zed)
                        INSTALL_ZED=true
                        ;;
                    ghostty)
                        INSTALL_GHOSTTY=true
                        ;;
                    vscode|vs-code)
                        INSTALL_VSCODE=true
                        ;;
                    opencode)
                        INSTALL_OPENCODE=true
                        ;;
                    *)
                        echo -e "${RED}Error: Unknown application '$app'${NC}"
                        echo "Valid options: zed, ghostty, vscode, opencode"
                        exit 1
                        ;;
                esac
            done
            shift 2
            ;;
        --skip)
            # Parse comma-separated list of applications to skip
            IFS=',' read -ra APPS <<< "$2"
            for app in "${APPS[@]}"; do
                app=$(echo "$app" | tr '[:upper:]' '[:lower:]' | xargs) # lowercase and trim
                case $app in
                    zed)
                        INSTALL_ZED=false
                        ;;
                    ghostty)
                        INSTALL_GHOSTTY=false
                        ;;
                    vscode|vs-code)
                        INSTALL_VSCODE=false
                        ;;
                    opencode)
                        INSTALL_OPENCODE=false
                        ;;
                    *)
                        echo -e "${RED}Error: Unknown application '$app'${NC}"
                        echo "Valid options: zed, ghostty, vscode, opencode"
                        exit 1
                        ;;
                esac
            done
            shift 2
            ;;
        -h|--help)
            echo "OpenCode Vibe Theme Installer"
            echo ""
            echo "Usage: $0 [OPTIONS]"
            echo ""
            echo "Options:"
            echo "  -f, --force           Overwrite existing theme files"
            echo "  -l, --link            Use symbolic links instead of copying (useful for development)"
            echo "  --only <apps>         Install only specified applications (comma-separated)"
            echo "  --skip <apps>         Skip specified applications (comma-separated)"
            echo "  -h, --help            Show this help message"
            echo ""
            echo "Applications:"
            echo "  zed                   Zed editor"
            echo "  ghostty               Ghostty terminal"
            echo "  vscode, vs-code       Visual Studio Code"
            echo "  opencode              OpenCode"
            echo ""
            echo "Examples:"
            echo "  $0                                    # Install all themes"
            echo "  $0 --only vscode,ghostty              # Install only VS Code and Ghostty"
            echo "  $0 --skip zed                         # Install all except Zed"
            echo "  $0 --force --link                     # Force reinstall with symlinks"
            echo "  $0 --only vscode --force              # Force reinstall VS Code only"
            echo ""
            echo "This script installs the OpenCode Vibe theme for:"
            echo "  - Zed editor (~/.config/zed/themes/)"
            echo "  - Ghostty terminal (~/.config/ghostty/themes/)"
            echo "  - VS Code (~/.vscode/extensions/)"
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

# Show what will be installed
APPS_TO_INSTALL=()
[ "$INSTALL_ZED" = true ] && APPS_TO_INSTALL+=("Zed")
[ "$INSTALL_GHOSTTY" = true ] && APPS_TO_INSTALL+=("Ghostty")
[ "$INSTALL_VSCODE" = true ] && APPS_TO_INSTALL+=("VS Code")
[ "$INSTALL_OPENCODE" = true ] && APPS_TO_INSTALL+=("OpenCode")

if [ ${#APPS_TO_INSTALL[@]} -eq 0 ]; then
    echo -e "${RED}Error: No applications selected for installation${NC}"
    exit 1
fi

echo -e "${BLUE}Installing for:${NC} ${APPS_TO_INSTALL[*]}"
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

# Function to copy or link directory with force check
copy_dir() {
    local src="$1"
    local dest="$2"
    local name="$3"
    
    # Check if source directory exists
    if [ ! -d "$src" ]; then
        echo -e "${RED}✗ Source directory not found: $src${NC}"
        return 1
    fi
    
    # Create parent directory if it doesn't exist
    mkdir -p "$(dirname "$dest")"
    
    # Check if destination directory exists
    if [ -d "$dest" ] || [ -L "$dest" ]; then
        if [ "$FORCE" = true ]; then
            rm -rf "$dest"
            if [ "$LINK" = true ]; then
                ln -s "$src" "$dest"
                echo -e "${GREEN}✓ $name (linked, overwritten)${NC}"
            else
                cp -r "$src" "$dest"
                echo -e "${GREEN}✓ $name (copied, overwritten)${NC}"
            fi
        else
            if [ "$LINK" = true ] && [ ! -L "$dest" ]; then
                echo -e "${YELLOW}⊘ $name (already exists as directory, use -f -l to overwrite with link)${NC}"
            else
                echo -e "${YELLOW}⊘ $name (already exists, use -f to overwrite)${NC}"
            fi
        fi
    else
        if [ "$LINK" = true ]; then
            ln -s "$src" "$dest"
            echo -e "${GREEN}✓ $name (linked)${NC}"
        else
            cp -r "$src" "$dest"
            echo -e "${GREEN}✓ $name (copied)${NC}"
        fi
    fi
}

# Install Zed theme
if [ "$INSTALL_ZED" = true ]; then
    echo -e "${BLUE}Installing Zed theme...${NC}"
    copy_file \
        "$SCRIPT_DIR/themes/zed/opencode-vibe.json" \
        "$HOME/.config/zed/themes/opencode-vibe.json" \
        "Zed theme"
    echo ""
fi

# Install Ghostty themes
if [ "$INSTALL_GHOSTTY" = true ]; then
    echo -e "${BLUE}Installing Ghostty themes...${NC}"
    copy_file \
        "$SCRIPT_DIR/themes/ghostty/opencode-vibe" \
        "$HOME/.config/ghostty/themes/opencode-vibe" \
        "Ghostty theme (dark)"
    copy_file \
        "$SCRIPT_DIR/themes/ghostty/opencode-vibe-light" \
        "$HOME/.config/ghostty/themes/opencode-vibe-light" \
        "Ghostty theme (light)"
    echo ""
fi

# Install VS Code theme
if [ "$INSTALL_VSCODE" = true ]; then
    echo -e "${BLUE}Installing VS Code theme...${NC}"
    copy_dir \
        "$SCRIPT_DIR/themes/vscode" \
        "$HOME/.vscode/extensions/opencode-vibe-1.0.0" \
        "VS Code theme"
    echo ""
fi

# Install OpenCode theme
if [ "$INSTALL_OPENCODE" = true ]; then
    echo -e "${BLUE}Installing OpenCode theme...${NC}"
    copy_file \
        "$SCRIPT_DIR/themes/opencode/opencode-vibe.json" \
        "$HOME/.config/opencode/themes/opencode-vibe.json" \
        "OpenCode theme"
    echo ""
fi
echo -e "${GREEN}Installation complete!${NC}"
echo ""
echo "Next steps:"
echo ""

if [ "$INSTALL_ZED" = true ]; then
    echo -e "${BLUE}Zed:${NC}"
    echo "  - Press Cmd+K then Cmd+T (or Ctrl+K then Ctrl+T on Linux)"
    echo "  - Search for 'OpenCode Vibe' and select it"
    echo "  Or add to ~/.config/zed/settings.json:"
    echo '    { "theme": "OpenCode Vibe" }'
    echo ""
fi

if [ "$INSTALL_GHOSTTY" = true ]; then
    echo -e "${BLUE}Ghostty:${NC}"
    echo "  - Add to ~/.config/ghostty/config:"
    echo "    theme = opencode-vibe           # for dark theme"
    echo "    theme = opencode-vibe-light     # for light theme"
    echo "  - Restart Ghostty or reload configuration"
    echo ""
fi

if [ "$INSTALL_VSCODE" = true ]; then
    echo -e "${BLUE}VS Code:${NC}"
    echo "  - Reload VS Code (Ctrl+Shift+P / Cmd+Shift+P → 'Developer: Reload Window')"
    echo "  - Press Ctrl+K Ctrl+T (or Cmd+K Cmd+T on macOS)"
    echo "  - Search for 'OpenCode Vibe' or 'OpenCode Vibe Light'"
    echo "  - Select it to apply"
    echo ""
fi

if [ "$INSTALL_OPENCODE" = true ]; then
    echo -e "${BLUE}OpenCode:${NC}"
    echo "  - Add to ~/.config/opencode/opencode.json:"
    echo '    { "theme": "opencode-vibe" }'
    echo ""
fi
