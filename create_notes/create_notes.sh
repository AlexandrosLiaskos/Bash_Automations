#!/bin/bash

NOTES_DIR="$HOME/Notes"
mkdir -p "$NOTES_DIR"

if [ -z "$EDITOR" ]; then
    EDITOR="nano"
fi

create_note() {
    read -p "Enter note title: " title
    filename=$(echo "$title" | tr ' ' '_').md
    filepath="$NOTES_DIR/$filename"
    
    tmpfile=$(mktemp)
    echo -e "# $title\n" > "$tmpfile"
    
    if [ -f "$filepath" ]; then
        echo "Note already exists."
        return
    fi

    $EDITOR "$tmpfile"
    cat "$tmpfile" > "$filepath"
    rm "$tmpfile"
    echo "Note saved to: $filepath"
    
    (cd "$NOTES_DIR" && \
     git add . && \
     git commit -m "+" && \
     git branch -m main && \
     git push -u origin main --force) 2>/dev/null
}

view_notes() {
    files=($(ls "$NOTES_DIR"/*.md 2>/dev/null))
    
    if [ ${#files[@]} -eq 0 ]; then
        echo "No notes found."
        return
    fi
    
    echo "Available notes:"
    for i in "${!files[@]}"; do
        filename=$(basename "${files[$i]}")
        echo "$((i+1)). ${filename%.md}"
    done
    
    echo -e "\nNavigation in less:"
    echo "- 'q' to quit reading"
    echo "- Arrow keys or Space/B to navigate"
    echo "- 'h' for help menu"
    
    read -p "Enter note number to view: " selection
    
    if [[ "$selection" =~ ^[0-9]+$ ]] && [ "$selection" -ge 1 ] && [ "$selection" -le ${#files[@]} ]; then
        less "${files[$((selection-1))]}"
    else
        echo "Invalid selection."
    fi
}

modify_note() {
    files=($(ls "$NOTES_DIR"/*.md 2>/dev/null))
    
    if [ ${#files[@]} -eq 0 ]; then
        echo "No notes found."
        return
    fi
    
    echo "Available notes:"
    for i in "${!files[@]}"; do
        filename=$(basename "${files[$i]}")
        echo "$((i+1)). ${filename%.md}"
    done
    
    read -p "Enter note number to modify: " selection
    
    if [[ "$selection" =~ ^[0-9]+$ ]] && [ "$selection" -ge 1 ] && [ "$selection" -le ${#files[@]} ]; then
        filepath="${files[$((selection-1))]}"
        tmpfile=$(mktemp)
        cat "$filepath" > "$tmpfile"
        
        $EDITOR "$tmpfile"
        cat "$tmpfile" > "$filepath"
        rm "$tmpfile"
        
        (cd "$NOTES_DIR" && \
         git add . && \
         git commit -m "+" && \
         git branch -m main && \
         git push -u origin main --force) 2>/dev/null
        
        echo "Note updated."
    else
        echo "Invalid selection."
    fi
}

delete_note() {
    files=($(ls "$NOTES_DIR"/*.md 2>/dev/null))
    
    if [ ${#files[@]} -eq 0 ]; then
        echo "No notes found."
        return
    fi
    
    echo "Available notes:"
    for i in "${!files[@]}"; do
        filename=$(basename "${files[$i]}")
        echo "$((i+1)). ${filename%.md}"
    done
    
    read -p "Enter note number to delete: " selection
    
    if [[ "$selection" =~ ^[0-9]+$ ]] && [ "$selection" -ge 1 ] && [ "$selection" -le ${#files[@]} ]; then
        read -p "Are you sure you want to delete this note? (y/n): " confirm
        if [ "$confirm" = "y" ] || [ "$confirm" = "Y" ]; then
            rm "${files[$((selection-1))]}"
            echo "Note deleted."
            
            (cd "$NOTES_DIR" && \
             git add . && \
             git commit -m "+" && \
             git branch -m main && \
             git push -u origin main --force) 2>/dev/null
        fi
    else
        echo "Invalid selection."
    fi
}

while true; do
    echo -e "\n1. Create note"
    echo "2. View notes"
    echo "3. Modify note"
    echo "4. Delete note"
    echo "5. Exit"
    
    read -p "Choose action (1-5): " choice
    
    case $choice in
        1) create_note ;;
        2) view_notes ;;
        3) modify_note ;;
        4) delete_note ;;
        5) break ;;
        *) echo "Invalid choice." ;;
    esac

    read -p "Do you want to perform another action? (y/n): " continue_choice
    if [ "$continue_choice" != "y" ] && [ "$continue_choice" != "Y" ]; then
        break
    fi
done

exit 0