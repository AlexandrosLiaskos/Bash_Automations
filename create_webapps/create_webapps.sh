#!/bin/bash

# Create webapp launcher script
create_webapp() {
    echo "Creating web application launcher..."
    
    # Get user input
    read -p "Enter application name: " app_name
    read -p "Enter URL: " url
    
    # Create filename by replacing spaces with underscores
    filename="${app_name// /_}.desktop"
    target_dir="$HOME/.local/share/applications"
    
    # Create .desktop file contents
    contents="[Desktop Entry]
Version=1.0
Type=Application
Name=$app_name
Exec=xdg-open \"$url\"
Terminal=false
Categories=Network;"
    
    # Write to file
    echo "$contents" > "$target_dir/$filename"
    
    # Set permissions
    chmod +x "$target_dir/$filename"
    
    echo "Created: $target_dir/$filename"
}

# Main loop
while true; do
    create_webapp
    read -p "Create another? (y/n) " -n 1 -r
    echo  # move to new line
    [[ $REPLY =~ ^[Yy]$ ]] || break
done

echo "Done! Find your new apps in the application menu."
