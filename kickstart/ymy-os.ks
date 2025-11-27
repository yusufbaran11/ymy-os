# YmY OS 43 Beta - Kickstart Configuration
# Based on Fedora 43

# System language
lang tr_TR.UTF-8

# Keyboard layouts
keyboard --vckeymap=tr --xlayouts='tr'

# System timezone
timezone Europe/Istanbul --utc

# Root password (will be set during installation)
rootpw --iscrypted --lock

# Create user account
user --name=ymy --groups=wheel --iscrypted --password=$6$rounds=4096$defaultpassword

# Network information
network --bootproto=dhcp --device=link --activate

# SELinux configuration
selinux --enforcing

# Firewall configuration
firewall --enabled --service=mdns

# System bootloader configuration
bootloader --location=mbr --timeout=5

# Clear the Master Boot Record
zerombr

# Partition clearing information
clearpart --all --initlabel

# Disk partitioning
autopart --type=lvm

# System services
services --enabled=NetworkManager,sshd,chronyd

# Package selection
%packages
@^workstation-product-environment
@base
@core
@fonts
@gnome-desktop
@hardware-support
@multimedia
@networkmanager-submodules

# Additional packages
gnome-tweaks
gnome-extensions-app
firefox
libreoffice
vlc
gimp
transmission
gnome-weather
gnome-calculator
gnome-calendar
gnome-clocks
gnome-maps

# Codec support
gstreamer1-plugins-base
gstreamer1-plugins-good
gstreamer1-plugins-bad-free
gstreamer1-plugins-ugly-free
gstreamer1-plugin-libav

# Turkish language support
langpacks-tr
hunspell-tr

# System utilities
htop
neofetch
vim
wget
curl
git

-@dial-up
-@guest-desktop-agents

%end

# Post installation script
%post --nochroot --log=/mnt/sysimage/root/ymy-os-install.log

# Copy branding files
cp -r /run/install/repo/branding/* /mnt/sysimage/usr/share/pixmaps/

%end

%post --log=/root/ymy-os-post-install.log

# Set hostname
hostnamectl set-hostname ymy-os

# Enable RPM Fusion repositories
dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
dnf install -y https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# Update system
dnf update -y

# Set default wallpaper
mkdir -p /usr/share/backgrounds/ymy-os
# Wallpaper will be added during build process

# Configure GNOME settings
cat > /etc/dconf/db/local.d/01-ymy-os << 'EOF'
[org/gnome/desktop/background]
picture-uri='file:///usr/share/backgrounds/ymy-os/default-wallpaper.jpg'
picture-uri-dark='file:///usr/share/backgrounds/ymy-os/default-wallpaper-dark.jpg'

[org/gnome/desktop/interface]
gtk-theme='Adwaita'
icon-theme='Adwaita'
enable-hot-corners=false

[org/gnome/desktop/wm/preferences]
button-layout='appmenu:minimize,maximize,close'

[org/gnome/shell]
favorite-apps=['org.gnome.Nautilus.desktop', 'firefox.desktop', 'org.gnome.Terminal.desktop', 'libreoffice-writer.desktop', 'org.gnome.Software.desktop']
EOF

dconf update

# Create welcome screen script
cat > /usr/local/bin/ymy-welcome << 'EOF'
#!/bin/bash
zenity --info --title="YmY OS'a Hoş Geldiniz!" --width=400 --height=200 --text="<b>YmY OS 43 Beta</b>\n\nLinux dünyasına hoş geldiniz!\n\nBaşlamak için Etkinlikler menüsünden uygulamaları keşfedebilirsiniz.\n\n<b>YmY Studios</b>"
EOF

chmod +x /usr/local/bin/ymy-welcome

# Add welcome screen to autostart
mkdir -p /etc/xdg/autostart
cat > /etc/xdg/autostart/ymy-welcome.desktop << 'EOF'
[Desktop Entry]
Type=Application
Name=YmY OS Welcome
Exec=/usr/local/bin/ymy-welcome
OnlyShowIn=GNOME;
X-GNOME-Autostart-enabled=true
EOF

# Clean up
dnf clean all

echo "YmY OS 43 Beta post-installation completed!"

%end

# Reboot after installation
reboot
