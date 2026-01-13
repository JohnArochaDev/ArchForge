#!/bin/bash

# Script to remove unwanted pre-installed software from Omarchy

echo "Removing unwanted software..."
echo ""

# Check if running as root
if [ "$EUID" -eq 0 ]; then
    echo "Don't run as root!"
    exit 1
fi

# Remove packages with dependencies together (must be removed as a group)
echo "Removing fd and its dependents..."
sudo pacman -Rns --noconfirm fd elephant-files 2>/dev/null && echo "✓ Removed fd and elephant-files" || echo "⊘ Already removed or not installed"
echo ""

echo "Removing ripgrep and its dependents..."
sudo pacman -Rns --noconfirm ripgrep opencode 2>/dev/null && echo "✓ Removed ripgrep and opencode" || echo "⊘ Already removed or not installed"
echo ""

echo "Removing cups printing stack..."
sudo pacman -Rns --noconfirm cups cups-filters cups-pdf cups-browsed system-config-printer 2>/dev/null && echo "✓ Removed printing stack" || echo "⊘ Already removed or not installed"
echo ""

# List of individual packages to remove
PACKAGES_TO_REMOVE=(
    # System info display
    "neofetch"
    
    # Modern CLI tools (I like old fashioned cmds)
    "bat"           # Better cat with syntax highlighting
    "eza"           # Better ls with colors/icons
    "fzf"           # Fuzzy finder for interactive search
    "zoxide"        # Smart cd command
    
    # Terminal emulators (not using, using ghostty)
    "alacritty"
    
    # Communication & productivity apps
    "signal-desktop"    # Messenger
    "obsidian"          # Note-taking app
    "typora"            # Markdown editor
    
    # Media editing (heavy apps)
    "kdenlive"          # Video editor (~500MB)
    
    # Password management
    "1password-beta"
    "1password-cli"
    
    # Input methods (Asian language support)
    "fcitx5"
    "fcitx5-gtk"
    "fcitx5-qt"
    
    # Misc/unknown
    "aether"            # P2P forum software
    "tobi-try"          # Tool for repetitive directories
    "impala"            # Terminal UI framework
)

# Remove each individual package
for package in "${PACKAGES_TO_REMOVE[@]}"; do
    if pacman -Qi "$package" &> /dev/null; then
        echo "Removing $package..."
        sudo pacman -Rns --noconfirm "$package"
        echo "✓ Removed $package"
    else
        echo "⊘ $package not installed, skipping"
    fi
    echo ""
done

# Clean up orphaned packages
echo "Cleaning up orphaned dependencies..."
sudo pacman -Rns --noconfirm $(pacman -Qtdq) 2>/dev/null

echo ""
echo "Done! Removed unwanted software."
echo "Run 'pacman -Qe' to see what's still installed."