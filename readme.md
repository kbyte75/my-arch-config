# My ARCH-Hyprland Config

1. Download or clone this repository.
2. Copy all files to `~/.config`, except for `nanorc`, `sddm-login-theme`.
3. Copy `nanorc` in `/etc/`.
4. Copy `sddm-login-theme` in `/usr/share/sddm/themes`.

## Install Dependencies

```bash
 sudo pacman -S waybar wlogout swww rofi fish fastfetch sddm kitty make cmake base-devel git nano python-pyquery --needed
```

## Install Yay

```bash
 git clone https://aur.archlinux.org/yay. git
 cd yay
 makepkg -si
```

## Install oh-my-posh

```bash
 yay -S oh-my-posh --noconfirm
```

## Change Default Shell to Fish

```bash
 chsh -s /usr/local/bin/fish
```

## Screenshots

```bash
 sudo pacman -S grim slurp --noconfirm
 mkdir -p ~/Pictures/Screenshots
```

## Download Fonts, Themes, Cursor, Icon

- **Bibata Modern Ice Cursor**: [Click](https://github.com/ful1e5/Bibata_Cursor)
- **WhitSur Icons**: [Click](https://github.com/vinceliuice/WhiteSur-icon-theme)

- **Rubik**: [Link](https://fonts.google.com/selection?query=rubik)
- **FiraCode Nerd Font**: [Link](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/FiraCode.zip)
- **Monoid Nerd Font**: [Link](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Monoid.zip)

## Set permissions

```bash
 sudo chmod +x ~/.config/hypr/scripts/switch_wallpaper.sh
 sudo chmod +x ~/.config/hypr/scripts/reload_waybar.sh
 sudo chmod +x ~/.config/hypr/scripts/toggle_rofi.sh
 sudo chmod +x ~/.config/hypr/scripts/toggle_bar.sh
 sudo chmod +x ~/.config/hypr/scripts/toggle_clipboard.sh

 sudo chmod +x ~/.config/waybar/scripts/adjust_volume.sh
 sudo chmod +x ~/.config/waybar/scripts/app_title.sh
 sudo chmod +x ~/.config/waybar/scripts/toggle_bluetooth.sh
 sudo chmod +x ~/.config/waybar/scripts/weather.py
```

## Setup Cursors, Theme, Icons, Fonts

```bash
 gsettings set org.gnome.desktop.interface cursor-theme 'Bibata-Modern-Ice'
 gsettings set org.gnome.desktop.interface icon-theme 'WhiteSur-green'
 gsettings set org.gnome.desktop.interface font-name 'Rubik Medium 10'
 gsettings set org.gnome.desktop.interface document-font-name 'JetBrains Mono 10'
 gsettings set org.gnome.desktop.interface monospace-font-name 'JetBrains Mono 10'
```
