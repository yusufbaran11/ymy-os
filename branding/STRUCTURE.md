# YmY OS Branding Yapısı

branding/
├── logos/
│ ├── ymy-logo-dark.png # Koyu mod (1024x1024)
│ ├── ymy-logo-light.png # Açık mod (1024x1024)
│ └── README.md # Logo dokümantasyonu
│
├── gnome/
│ ├── ymy-os-branding-gnome.gschema.xml # GNOME şeması
│ ├── ymy-os-welcome.desktop # Hoşgeldiniz uygulaması
│ ├── first-run-setup.sh # İlk çalıştırma ayarları
│ ├── install-extensions.sh # Eklenti kurulumu
│ ├── ymy-os-welcome.py # Python uygulaması
│ └── dconf-defaults.ini # Dconf varsayılan değerleri
│
├── wallpapers/
│ ├── ymy-wallpaper-light.jpg # Açık mod duvar kağıdı
│ ├── ymy-wallpaper-dark.jpg # Koyu mod duvar kağıdı
│ └── ymy-lockscreen.jpg # Ekran kilidi arka planı
│
├── themes/
│ ├── gtk-3.0/
│ ├── gtk-4.0/
│ └── gnome-shell/
│
└── THEME_INFO.md # Tema bilgisi

## Dosya Konumları (Kurulum Sonrası)

/usr/share/pixmaps/
├── ymy-logo-dark.png
└── ymy-logo-light.png

/usr/share/backgrounds/ymy-os/
├── ymy-wallpaper-light.jpg
├── ymy-wallpaper-dark.jpg
└── ymy-lockscreen.jpg

/usr/share/glib-2.0/schemas/
└── org.ymy.os.gnome.gschema.xml

/usr/share/applications/
└── ymy-os-welcome.desktop

/usr/share/ymy-os/
├── first-run-setup.sh
└── install-extensions.sh
