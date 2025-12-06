# YmY OS 43 Beta - GNOME Özelleştirilmiş Edition
# Fedora 43 Tabanlı Linux Dağıtımı
# Version: 43 Beta
# Hedef: Yeni Kullanıcılar

lang tr_TR.UTF-8
keyboard --xlayouts=tr
timezone Europe/Istanbul --utc

# Repository'ler
repo --name=fedora --baseurl=https://dl.fedoraproject.org/pub/fedora/linux/releases/43/Everything/$basearch/os/
repo --name=updates --baseurl=https://dl.fedoraproject.org/pub/fedora/linux/updates/43/$basearch/

# Kurulum Ayarları
text
skipx
zerombr
clearpart --all --initlabel
autopart --type=lvm --fstype=ext4

# Bootloader
bootloader --location=mbr --append="rhgb quiet" --timeout=10

# Network
network --bootproto=dhcp --onboot=yes --activate

# Firewall & SELinux
firewall --enabled --service=mdns
selinux --enforcing

# GNOME Desktop Environment
%packages
@core
@gnome-desktop
@gnome-games
@multimedia
@development-tools

# GNOME Temel
gdm
gnome-session
gnome-desktop
gnome-terminal
gnome-text-editor
gnome-calculator
gnome-calendar
gnome-weather
gnome-clocks
gnome-maps
gnome-control-center

# GNOME Eklentileri
gnome-shell-extensions
gnome-shell-extension-dash-to-dock
gnome-shell-extension-appindicator
gnome-shell-extension-desktop-icons-ng

# Sistem Araçları (Yeni Kullanıcılar İçin Basit)
nano
gedit
nautilus
nautilus-sendto
eog
evince

# Ağ ve İnternet
firefox
thunderbird
wget
curl

# Multimedya (Kolay Kullanımlı)
vlc
rhythmbox
gnome-photos
gnome-music

# Ofis
libreoffice-writer
libreoffice-calc
libreoffice-impress
libreoffice-draw

# Öğretim Amaçlı (Yeni Kullanıcılar)
git
python3
python3-pip
geany

# Diğer Araçlar
baobab
gnome-dictionary
gnome-logs
gnome-power-profiles-daemon
gdm-pwcrypt

# YmY OS Branding
ymy-os-branding-gnome
ymy-os-wallpapers

%end

# Pre-Install
%pre
echo "🎨 YmY OS 43 Beta Kurulumu Başlıyor..."
%end

# Post-Install
%post
echo "⚙️  Sistem Yapılandırması Başlıyor..."

# Yerelleştirme
localectl set-locale LANG=tr_TR.UTF-8
localectl set-keymap tr

# Zaman Dilimi
timedatectl set-timezone Europe/Istanbul

# GNOME İlk Çalıştırma Komut Dosyasını Kurulum
if [ -f /usr/share/ymy-os/first-run-setup.sh ]; then
    chmod +x /usr/share/ymy-os/first-run-setup.sh
    echo "✓ İlk çalıştırma komut dosyası kuruldu"
fi

# Yapılandırma
echo "✓ Sistem yapılandırılıyor..."

# GNOME Başlangıç Uygulaması
mkdir -p /etc/xdg/autostart
cp /usr/share/applications/ymy-os-welcome.desktop /etc/xdg/autostart/

# YmY OS Yazılım Merkezi
echo "✓ GNOME Yazılım Merkezi iyileştiriliyor..."

# Dosya Yöneticisi Tercihler
gsettings set org.gnome.nautilus.preferences default-folder-viewer 'list-view'

# Panel Saatini Ayarla
gsettings set org.gnome.desktop.interface clock-format '24h'

# Tema Ayarları
gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita'
gsettings set org.gnome.desktop.interface icon-theme 'Adwaita'
gsettings set org.gnome.desktop.interface color-scheme 'light'

# Masaüstü Simgeleri
gsettings set org.gnome.shell disable-extension-version-validation true

# Son Mesaj
echo ""
echo "✅ YmY OS 43 Beta Kurulumu Tamamlandı!"
echo "🎉 Sisteminize Hoşgeldiniz!"
echo ""
echo "💡 İpucu: İlk açılışta size hoşgeldiniz ekranı gösterilecektir."
echo ""

%end

%post --nochroot
echo "🎨 Branding Dosyaları Kopyalanıyor..."

# Logo dosyalarını doğru yere kopyala
if [ -d "$INSTALL_ROOT/usr/share/pixmaps" ]; then
    cp /usr/share/pixmaps/ymy-logo-*.png "$INSTALL_ROOT/usr/share/pixmaps/" 2>/dev/null || true
fi

%end
