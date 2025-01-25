# Notes Management Scripts 📝

Bash scripts for creating and viewing markdown notes. 

⚠️ Before starting, check the [requirements](#%EF%B8%8F-requirements) section below.

## 📥 Quick Install

```bash
# Download scripts
wget https://raw.githubusercontent.com/AlexandrosLiaskos/Bash_Automations/main/create_notes/create_notes.sh
wget https://raw.githubusercontent.com/AlexandrosLiaskos/Bash_Automations/main/create_notes/view_notes.sh

# Make executable
chmod +x create_notes.sh view_notes.sh
```

## 🛠️ Usage

### Create Notes
```bash
./create_notes.sh
```

Features:
- Creates markdown notes in ~/Notes
- Supports overwriting or appending to existing notes
- Uses system's default editor (EDITOR env variable)
- Auto-commits changes to git repository using 'push' alias

### View Notes
```bash
./view_notes.sh
```

Features:
- Lists all markdown notes
- Interactive note selection
- Views notes using 'less' pager

## 📁 File Structure
Notes are stored in:
```
~/Notes/*.md
```

## ⚙️ Requirements
- Git (for auto-commit feature)
- Text editor (defaults to nano)
- Git alias 'push' configured as:
  ```bash
  alias push='git add . && git commit -m "+" && git branch -m main && git push -u origin main --force'
  ```