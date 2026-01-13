#!/bin/bash

# Script adds fastfetch to ~/.bashrc

echo "Adding fastfetch to terminal startup..."
echo ""

BASHRC="$HOME/.bashrc"

# Check if fastfetch is already in bashrc
if grep -q "^fastfetch" "$BASHRC"; then
  echo "⊘ Fastfetch already configured, skipping"
else
  # Add fastfetch to the END of .bashrc
  echo " " >> "$BASHRC"
  echo "# Display system info on terminal startup" >> "$BASHRC"
  echo "fastfetch" >> "$BASHRC"
  echo "✓ Added fastfetch to .bashrc"
fi

echo ""
echo "Done! Open a new terminal to see fastfetch."