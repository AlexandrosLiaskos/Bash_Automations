#!/bin/bash

NOTES_DIR="$HOME/Notes"

# Check if Notes directory exists
if [ ! -d "$NOTES_DIR" ]; then
    echo "Notes directory not found."
    exit 1
fi

# List all markdown files
files=($(ls "$NOTES_DIR"/*.md 2>/dev/null))

if [ ${#files[@]} -eq 0 ]; then
    echo "No notes found."
    exit 1
fi

# Display numbered list of notes
echo "Available notes:"
for i in "${!files[@]}"; do
    filename=$(basename "${files[$i]}")
    echo "$((i+1)). ${filename%.md}"
done

echo -e "\nNavigation in less:"
echo "- 'q' to quit reading"
echo "- Arrow keys or Space/B to navigate"
echo "- 'h' for help menu"

# Get user selection
while true; do
    read -p "Enter note number to view (or 'q' to quit): " selection
    
    if [ "$selection" = "q" ]; then
        exit 0
    fi
    
    if [[ "$selection" =~ ^[0-9]+$ ]] && [ "$selection" -ge 1 ] && [ "$selection" -le ${#files[@]} ]; then
        # Display note content using less
        less "${files[$((selection-1))]}"
        break
    else
        echo "Invalid selection. Please try again."
    fi
done