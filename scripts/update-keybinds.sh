#!/bin/bash

# This modifies the Hyprland bindings configuration.
#
# IMPORTANT: never edit files under ~/.local/share/omarchy/ (that's Omarchy's
# own package tree). `omarchy update` overwrites it, silently undoing any
# edit made there and re-introducing whatever conflict we were fixing. Only
# ~/.config/hypr/bindings.conf is safe to touch: it's user-owned and sourced
# *after* Omarchy's defaults, so an `unbind` there always wins regardless of
# what a future update changes upstream. This script used to sed-delete
# hardcoded line numbers out of tiling-v2.conf, which is exactly what broke
# after the last Omarchy update (SUPER+T went back to also firing
# togglefloating, floating the previously active window at full size on top
# of the new terminal).

CONFIG_FILE="$HOME/.config/hypr/bindings.conf"

if [ ! -f "$CONFIG_FILE" ]; then
    echo "Error: Config file not found at $CONFIG_FILE"
    exit 1
fi

echo "Updating keybindings..."
echo ""

# Add an unbind line if it isn't already present (idempotent, update-proof
# override of whatever Omarchy's current defaults bind that combo to).
add_unbind_once() {
    local combo="$1"
    if ! grep -qF "unbind = $combo" "$CONFIG_FILE"; then
        echo "unbind = $combo" >> "$CONFIG_FILE"
    fi
}

# Terminal on SUPER+T.
# Omarchy's tiling-v2 default binds SUPER+T to togglefloating. Unbind it
# every run so the override survives `omarchy update` resetting the
# default file back to stock.
add_unbind_once "SUPER, T"
# Remove any previous terminal bind (old SUPER+RETURN, or a stale SUPER+T
# one from a prior run) before re-adding, so re-running stays idempotent.
sed -i '/bindd = SUPER, RETURN, Terminal/d; /bindd = SUPER, T, Terminal/d' "$CONFIG_FILE"
echo 'bindd = SUPER, T, Terminal, exec, uwsm-app -- xdg-terminal-exec --dir="$(omarchy-cmd-terminal-cwd)"' >> "$CONFIG_FILE"

# Close windows on SUPER+Q.
if ! grep -q "bindd = SUPER, Q.*killactive" "$CONFIG_FILE"; then
    echo "bindd = SUPER, Q, Close window, killactive," >> "$CONFIG_FILE"
fi

# Toggle floating on SUPER+W.
# Omarchy's tiling-v2 default binds SUPER+W to killactive, which duplicated
# SUPER+Q above. Unbind it and repurpose SUPER+W for togglefloating (what
# SUPER+T used to also trigger before it was freed up for the terminal).
add_unbind_once "SUPER, W"
sed -i '/bindd = SUPER, W.*togglefloating/d' "$CONFIG_FILE"
echo "bindd = SUPER, W, Toggle floating/tiling, togglefloating," >> "$CONFIG_FILE"

# NOTE: we intentionally do NOT bind SUPER+F to togglefloating any more.
# Omarchy's tiling-v2 default binds SUPER+F to fullscreen; adding a
# togglefloating bind on the same combo without unbinding the default
# caused both to fire together (the SUPER+F equivalent of the SUPER+T bug
# above). If you want a floating toggle back, pick a free combo instead of
# re-overloading F.
sed -i '/bindd = SUPER, F.*togglefloating/d' "$CONFIG_FILE"

echo ""

# Verify
if grep -q "unbind = SUPER, T" "$CONFIG_FILE" && grep -q "bindd = SUPER, T, Terminal" "$CONFIG_FILE"; then
    echo "✓ SUPER + T opens a terminal only (default togglefloating unbound)"
else
    echo "✗ Warning: Could not set up SUPER + T terminal binding"
fi

if grep -q "bindd = SUPER, Q.*killactive" "$CONFIG_FILE"; then
    echo "✓ SUPER + Q close window binding exists"
else
    echo "✗ Warning: Could not add SUPER + Q close window binding"
fi

if grep -q "unbind = SUPER, W" "$CONFIG_FILE" && grep -q "bindd = SUPER, W.*togglefloating" "$CONFIG_FILE"; then
    echo "✓ SUPER + W toggles floating only (default killactive unbound)"
else
    echo "✗ Warning: Could not set up SUPER + W toggle floating binding"
fi

# If Hyprland is running, reload and check for config errors right away.
if command -v hyprctl >/dev/null && hyprctl monitors >/dev/null 2>&1; then
    hyprctl reload >/dev/null
    ERRORS="$(hyprctl configerrors)"
    if [ -z "$ERRORS" ]; then
        echo "✓ Hyprland reloaded with no config errors"
    else
        echo "✗ Hyprland reported config errors:"
        echo "$ERRORS"
    fi
fi

echo ""
echo "Done! Press SUPER + SHIFT + R to reload Hyprland config"
