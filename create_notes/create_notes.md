# Notes Management Script 📝

A Bash script for creating, viewing, modifying, and deleting markdown notes.

⚠️ Before starting, check the [requirements](#%EF%B8%8F-requirements) section below.

## 📥 Quick Install

```bash
wget https://raw.githubusercontent.com/AlexandrosLiaskos/Bash_Automations/main/create_notes/create_notes.sh
chmod +x create_notes.sh
```

## 🛠️ Usage

```bash
./create_notes.sh
```

Features:
- Interactive menu with options:
  1. Create note
  2. View notes
  3. Modify note
  4. Delete note
  5. Exit
- Auto-commits and pushes changes
- Views notes using less pager:
  - 'q' to quit reading
  - Arrow keys or Space/B to navigate
  - 'h' for help menu

## 📁 File Structure
```
~/Notes/*.md
```

## ⚙️ Requirements
- Git (for auto-commit feature)
- Text editor (defaults to nano)
- Configured git repository in ~/Notes
  - Remote origin set up
  - Initial commit done