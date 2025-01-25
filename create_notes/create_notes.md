# Notes Management Script 📝

A Bash script for managing markdown notes with git integration.

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
  2. View/Edit note (uses your preferred editor)
  3. Delete notes (supports multiple deletions)
  4. Exit
- Auto-commits and pushes changes
- Continues to menu after each action

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