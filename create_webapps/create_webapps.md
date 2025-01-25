# Web App Launcher Generator 🚀

A minimalist bash script to create desktop web app launchers in Linux systems (Ubuntu/Debian-based).

## 📥 Requirements

- Git installed and configured
- A GitHub repository for storing webapp configurations
- `~/webapps` symlinked to `~/.local/share/applications`

## 📥 Installation & Setup

1. **Download script**:
```bash
wget https://raw.githubusercontent.com/AlexandrosLiaskos/Bash_Automations/main/create_webapps/create_webapps.sh
chmod +x create_webapps.sh
```

2. **Setup symlink and Git**:
```bash
ln -s ~/.local/share/applications ~/webapps
cd ~/webapps
git init
git remote add origin <your-repository-url>
```

## 🛠️ Usage

**Basic usage**:
```bash
./create_webapps.sh
```
Follow the prompts:
```
Enter application name: MyWebApp
Enter URL: https://example.com
Create another? (y/n) n
```

## 📁 File Structure
Launchers are stored in:
```
~/.local/share/applications/
~/webapps -> ~/.local/share/applications  # Symlink
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
- Zero dependencies (except Git)
- Auto-sanitized filenames
- Multi-launcher creation
- Instant menu integration
- Works with any browser
- Automatic Git backup

## Technical Details 🔧

- File location: ~/.local/share/applications/
- Symlink: ~/webapps -> ~/.local/share/applications
- Permissions: Automatically set to executable (+x)
- Compatibility: Any Linux with GNOME/KDE desktop
- Git operations: Auto-commit and push to main branch

## 📜 License
MIT License - Free for all use cases