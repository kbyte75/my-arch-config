# My ARCH-Hyprland Config

1. Download or clone this repository.
2. Copy all files to `~/.config`, except `nanorc`, `sddm-login-theme`.
3. Copy `nanorc` in `/etc/`.
4. Copy `sddm-login-theme` in `/usr/share/sddm/themes`.

## Required Dependencies

```bash
 sudo pacman -S waybar swww rofi fish fastfetch sddm kitty make cmake base-devel git nano python-pyquery grim slurp nwg-look nautilus font-manager blueman nm-connection-editor --needed
```

## Create Folder

```bash
  mkdir -p ~/Pictures
  mkdir -p ~/Pictures/Screenshots
  mkdir -p ~/Pictures/Wallpapers
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

## Download Fonts, Themes, Cursor, Icon

- **Bibata Modern Ice Cursor**: [Click](https://www.gnome-look.org/p/1197198)
- **MacTahoe Icon Theme**: [Click](https://www.gnome-look.org/p/2299216)

- **Rubik**: [Link](https://fonts.google.com/selection?query=rubik)
- **FiraCode Nerd Font**: [Link](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/FiraCode.zip)
- **Monoid Nerd Font**: [Link](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Monoid.zip)

## Set permissions

```bash
 sudo chmod +x ~/.config/hypr/scripts/*.sh
 sudo chmod +x ~/.config/waybar/scripts/*.sh
 sudo chmod +x ~/.config/rofi/scripts/*.sh
 sudo chmod +x ~/.config/waybar/scripts/weather.py
```

### Setup Cursor, Icon, Fonts with nwg-look
