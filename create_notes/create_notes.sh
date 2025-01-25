#!/bin/bash

# Check if EDITOR is set, if not default to nano
if [ -z "$EDITOR" ]; then
    EDITOR="nano"
fi

while true; do
    # Ensure the Notes directory exists
    NOTES_DIR="$HOME/Notes"
    mkdir -p "$NOTES_DIR"

    # Prompt for the note title
    read -p "Enter note title: " title

    # Convert title to a valid filename
    filename=$(echo "$title" | tr ' ' '_').md
    filepath="$NOTES_DIR/$filename"

    # Create temporary file
    tmpfile=$(mktemp)
    echo -e "# $title\n" > "$tmpfile"

    # Check if file exists and ask for action
    if [ -f "$filepath" ]; then
        read -p "Note exists. Do you want to (o)verwrite, (a)ppend, or (c)ancel? [o/a/c]: " action
        case "$action" in
            o|O)
                echo "Overwriting existing note..."
                ;;
            a|A)
                echo "Appending to existing note..."
                cat "$filepath" > "$tmpfile"
                echo -e "\n---\n" >> "$tmpfile"
                ;;
            *)
                echo "Operation cancelled."
                rm "$tmpfile"
                continue
                ;;
        esac
    fi

    # Open the temporary file in the editor
    $EDITOR "$tmpfile"

    # Save the content to the actual note file
    if [ -f "$filepath" ] && [ "$action" = "a" -o "$action" = "A" ]; then
        cat "$tmpfile" > "$filepath"
    else
        cat "$tmpfile" > "$filepath"
    fi

    # Clean up
    rm "$tmpfile"
    echo "Note saved to: $filepath"

    # Push changes to git repository
    cd "$NOTES_DIR" && push 2>/dev/null

    # Ask if user wants to create another note
    read -p "Do you want to create another note? (y/n): " continue_choice
    if [ "$continue_choice" != "y" ] && [ "$continue_choice" != "Y" ]; then
        break
    fi
    echo -e "\n-------------------\n"
done