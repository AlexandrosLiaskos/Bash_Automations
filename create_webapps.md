# Web App Launcher Generator 🚀

A minimalist bash script to create desktop web app launchers in Linux systems (Ubuntu/Debian-based).

## 📥 Installation & Setup

1. **Download script**:
```bash
wget https://raw.githubusercontent.com/AlexandrosLiaskos/Bash_Automations/main/create_webapps.sh
chmod +x create_webapps.sh
```

## 🛠️ Usage

**Basic usage**:
```bash
./create-webapp.sh
```
Follow the prompts:
```
Enter application name: MyWebApp
Enter URL: https://example.com
Create another? (y/n) n
```

## 📁 File Structure
Created launchers are stored in:
```
~/.local/share/applications/
```
Example file (`MyWebApp.desktop`):
```ini
[Desktop Entry]
Version=1.0
Type=Application
Name=MyWebApp
Exec=xdg-open "https://example.com"
Terminal=false
Categories=Network;
```

## ⚙️ Features
- Zero dependencies
- Auto-sanitized filenames
- Multi-launcher creation
- Instant menu integration
- Works with any browser

## Technical Details 🔧

- File location: ~/.local/share/applications/

- Permissions: Automatically set to executable (+x)

- Compatibility: Any Linux with GNOME/KDE desktop

## 📜 License
MIT License - Free for all use cases
