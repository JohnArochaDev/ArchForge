# Omarchy Custom Setup Script

A personalized setup script for Omarchy Linux that configures themes, keybinds, terminal customization, and removes bloat.

## Compatibility

**Omarchy Version:** 3.3.3

## Features

### 🎨 Custom Themes
- **Darkened State** - Dark theme with red accents and muted earth tones
- **Pixelated** - Soothing pixeldated backgrounds with natural colors

Both themes include:
- Custom color schemes (terminal, waybar, hyprland)
- Wallpaper collections
- Unified visual styling across the system

### ⌨️ Keybind Customizations
Custom keybindings tailored for improved workflow

### 💻 Terminal Customization
- Custom fastfetch configuration with personalized ASCII art
- Color scheme integration with Ghostty terminal
- Enhanced terminal aesthetics

### 🧹 Bloat Removal
Removes unnecessary pre-installed applications to streamline the system

## Installation

1. Clone this repository:
```bash
git clone <your-repo-url>
cd <repo-name>
```

2. Run the installation:
```bash
./install.sh
```

## File Structure
```
.
├── install.sh                      # Main installation script
├── README.md                       # This file
├── themes/
│   ├── darkened-state/            # Darkened State theme files
│   └── pixeldated/                # Pixeldated theme files
├── scripts/
│   ├── add-fastfetch.sh           # Install fastfetch
│   ├── delete-desktop-apps.sh     # Remove desktop applications
│   ├── edit-fastfetch.sh          # Configure fastfetch
│   ├── remove-bloat.sh            # Remove bloat packages
│   ├── theme-darkened-state.sh    # Install Darkened State theme
│   ├── theme-pixeldated.sh        # Install Pixeldated theme
│   └── update-keybinds.sh         # Update keybindings
└── files/
    └── ascii.txt                  # Custom ASCII art for fastfetch
```

## Themes Preview
*coming soon!*

### Darkened State
- Background: `#191716` (Deep brown-black)
- Accent: `#ff6f59` (Coral red)
- Focus: Warm, muted earth tones

### Pixelated
- Background: `#0D1F22` (Deep blue-green)
- Accent: `#B38A58` (Tan)
- Focus: Soothing/forest aesthetic

## Requirements

- Omarchy 3.3.3
- Git
- Basic shell utilities

## Contributing

Feel free to fork and customize for your own setup!

## License

MIT License - Feel free to use and modify

## Author

Created for my personal Omarchy setup

---

**Note:** Always review scripts before running them on your system. This script modifies system configurations and removes packages.