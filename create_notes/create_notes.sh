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
    
    if [ -f "$filepath" ]; then
        echo "Note already exists."
        return
    fi

    echo -e "# $title\n" > "$filepath"
    $EDITOR "$filepath"
    echo "Note saved to: $filepath"
    
    (cd "$NOTES_DIR" && \
     git add . && \
     git commit -m "+" && \
     git branch -m main && \
     git push -u origin main --force) 2>/dev/null
}

view_or_modify_note() {
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
    
    read -p "Enter note number to view/edit: " selection
    
    if [[ "$selection" =~ ^[0-9]+$ ]] && [ "$selection" -ge 1 ] && [ "$selection" -le ${#files[@]} ]; then
        $EDITOR "${files[$((selection-1))]}"
        
        (cd "$NOTES_DIR" && \
         git add . && \
         git commit -m "+" && \
         git branch -m main && \
         git push -u origin main --force) 2>/dev/null
    else
        echo "Invalid selection."
    fi
}

delete_notes() {
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
    
    echo "Enter note numbers to delete (space-separated) or 'all' for all notes:"
    read -r selections
    
    if [ "$selections" = "all" ]; then
        read -p "Are you sure you want to delete ALL notes? (y/n): " confirm
        if [ "$confirm" = "y" ] || [ "$confirm" = "Y" ]; then
            rm "$NOTES_DIR"/*.md
            echo "All notes deleted."
            (cd "$NOTES_DIR" && \
             git add . && \
             git commit -m "+" && \
             git branch -m main && \
             git push -u origin main --force) 2>/dev/null
        fi
        return
    fi
    
    read -p "Are you sure you want to delete these notes? (y/n): " confirm
    if [ "$confirm" = "y" ] || [ "$confirm" = "Y" ]; then
        for selection in $selections; do
            if [[ "$selection" =~ ^[0-9]+$ ]] && [ "$selection" -ge 1 ] && [ "$selection" -le ${#files[@]} ]; then
                rm "${files[$((selection-1))]}"
                echo "Deleted: ${files[$((selection-1))]}"
            else
                echo "Invalid selection: $selection"
            fi
        done
        
        (cd "$NOTES_DIR" && \
         git add . && \
         git commit -m "+" && \
         git branch -m main && \
         git push -u origin main --force) 2>/dev/null
    fi
}

while true; do
    echo -e "\n1. Create note"
    echo "2. View/Edit note"
    echo "3. Delete notes"
    echo "4. Exit"
    
    read -p "Choose action (1-4): " choice
    
    case $choice in
        1) create_note ;;
        2) view_or_modify_note ;;
        3) delete_notes ;;
        4) break ;;
        *) echo "Invalid choice." ;;
    esac

    read -p "Do you want to perform another action? (y/n): " continue_choice
    if [ "$continue_choice" != "y" ] && [ "$continue_choice" != "Y" ]; then
        break
    fi
done

exit 0