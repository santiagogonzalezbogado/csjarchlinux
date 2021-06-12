#!/bin/bash
set -e
kwriteconfig5 --file kwinrc --group ModifierOnlyShortcuts --key Meta "org.kde.krunner,/App,,display"
sudo pacman -Rscn discover oxygen plasma-vault
sed -i '/General/a \font=Inter, 14, -1,5,50,0,0,0,0,0' .config/krunnerrc
kwriteconfig5 --file startkderc --group General --key systemdBoot true
sudo journalctl --vacuum-size=100M
sudo journalctl --vacuum-time=2weeks
sed -i '/\[Windows\]/a BorderlessMaximizedWindows=true' .config/kwinrc

sudo mkdir -p /etc/sddm.conf.d/
sudo touch /etc/sddm.conf.d/autologin.conf
sudo tee -a /etc/sddm.conf.d/autologin.conf << EOF
[Autologin]
User=$USER
Session=plasmawayland.desktop
EOF
