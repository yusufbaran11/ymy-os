Name:           ymy-os-branding-gnome
Version:        43
Release:        beta.1%{?dist}
Summary:        YmY OS GNOME Branding ve Özelleştirmeler

License:        GPL-2.0
URL:            https://github.com/ymy-studios/ymy-os

BuildArch:      noarch

%description
YmY OS GNOME Desktop Environment için branding ve özelleştirme paketi.
Logolar, temalar ve GNOME eklentilerini içerir.

%files
%license LICENSE
%doc README.md

/usr/share/pixmaps/ymy-logo-*.png
/usr/share/backgrounds/ymy-os/
/usr/share/applications/ymy-os-welcome.desktop
/usr/share/glib-2.0/schemas/org.ymy.os.gnome.gschema.xml
/usr/share/ymy-os/

%post
glib-compile-schemas /usr/share/glib-2.0/schemas/

%postun
glib-compile-schemas /usr/share/glib-2.0/schemas/

%changelog
* Mon Jan 01 2024 YmY Studios <contact@ymy-os.dev>
- YmY OS 43 Beta Başlangıcı
- GNOME Branding Paketi
