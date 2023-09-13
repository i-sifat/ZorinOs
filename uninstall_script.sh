#!/bin/bash

# Check if the script is run as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run this script as root (use sudo)"
    exit 1
fi

# Color codes
WHITE='\033[0;97m'
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'  # No Color

# Get the total number of installed packages
total_installed_packages=$(dpkg -l | grep ^ii | wc -l)

# Create a line of underscores
line="------------------------------------"

echo -e "${WHITE}${line}"
echo -e "|                                |"
echo -e "|${GREEN} Installed packages: $total_installed_packages ${NC}|"
echo -e "|                                |"
echo -e "${line}"

# List of packages to uninstall
packages=(
    gimp
    brasero
    cheese
    gnome-characters
    gnome-mahjongg
    gnome-maps
    gnome-mines
    aisleriot
    evolution
    gnome-contacts
    libreoffice-base-core
    libreoffice-common
    libreoffice-core
    libreoffice-draw
    libreoffice-gnome
    libreoffice-gtk3
    libreoffice-help-common
    libreoffice-help-en-us
    libreoffice-impress
    libreoffice-style-colibre
    libreoffice-style-elementary
    libreoffice-style-yaru
    libreoffice-writer
    gnome-photos
    quadrapassel
    gnome-sudoku
    gnome-todo
    gnome-tour
    gnome-menus
    gnome-remote-desktop
    gnome-sound-recorder
    gnome-user-docs
    gnome-video-effects
    gnome-weather
    gnome-system-monitor
    gnome-remote-desktop
    simple-scan
    plymouth-theme-spinner
    plymouth-theme-ubuntu-text
    printer-driver-all
    printer-driver-brlaser
    printer-driver-c2050
    printer-driver-c2esp
    printer-driver-cjet
    printer-driver-dymo
    printer-driver-escpr
    printer-driver-fujixerox
    printer-driver-gutenprint
    printer-driver-hpcups
    printer-driver-hpijs
    printer-driver-m2300w
    printer-driver-min12xxw
    printer-driver-pnm2ppa
    printer-driver-postscript-hp
    printer-driver-ptouch
    printer-driver-pxljr
    printer-driver-sag-gdi
    printer-driver-splix
    zorin-gnome-tour-autostart
    zorin-os-docs
    zorin-os-printer-test-page
    zorin-os-tour-video
    zorin-sound-theme
    zorin-windows-app-support-installation-shortcut
)

# Prompt to show packages that will be checked and removed if they exist
echo -e "${RED}The following packages will be checked and removed if they exist:${NC}"

# Uninstall packages
for package in "${packages[@]}"; do
    if ! ($package --version) 2>/dev/null && ! (which $package) 2>/dev/null; then
        echo -e "${RED}The following package will be removed: $package"
        sudo apt remove "$package" -y
        echo -e "${line}"
        echo -e "| ${GREEN}\"$package\" is removed ${NC}|"
        echo -e "${line}"
        packages_removed=$((packages_removed + 1))
        packages_left=$((total_packages - packages_removed))
    else
        echo -e "${RED}$package is not installed."
    fi
done

# Additional cleanup
sudo apt autoremove -y
sudo apt clean -y

# Get the default system username
default_user=$(whoami)

# Change permissions and ownership
sudo chmod -R 755 /media/$default_user
sudo chown -R $default_user:$default_user /media/$default_user

# Install Flutter
echo -e "${WHITE}${line}"
echo -e "|                                |"
echo -e "| Installing Flutter             |"
echo -e "|                                |"
echo -e "${line}"
cd ~/development
wget https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.13.3-stable.tar.xz
tar xf flutter_linux_3.13.3-stable.tar.xz
export PATH="$PATH:`pwd`/flutter/bin"
flutter doctor --android-licenses

# Install Android Studio
echo -e "${WHITE}${line}"
echo -e "|                                |"
echo -e "| Installing Android Studio      |"
echo -e "|                                |"
echo -e "${line}"
wget https://redirector.gvt1.com/edgedl/android/studio/ide-zips/2022.3.1.19/android-studio-2022.3.1.19-linux.tar.gz
tar -xzf android-studio-2022.3.1.19-linux.tar.gz
sudo mv android-studio /opt/
/opt/android-studio/bin/studio.sh

# Install required 32-bit libraries for Android Studio
echo -e "${WHITE}${line}"
echo -e "|                                |"
echo -e "| Installing 32-bit Libraries    |"
echo -e "|                                |"
echo -e "${line}"
sudo apt-get install libc6:i386 libncurses5:i386 libstdc++6:i386 lib32z1 libbz2-1.0:i386

# Install Visual Studio Code
echo -e "${WHITE}${line}"
echo -e "|                                |"
echo -e "| Installing Visual Studio Code   |"
echo -e "|                                |"
echo -e "${line}"
wget https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64 -O code.deb
sudo apt install ./code.deb

# Install Motrix Download Manager
echo -e "${WHITE}${line}"
echo -e "|                                |"
echo -e "| Installing Motrix Download Manager |"
echo -e "|                                |"
echo -e "${line}"
wget https://dl.motrix.app/release/Motrix_1.8.19_amd64.deb
sudo apt install ./Motrix_1.8.19_amd64.deb

# Install Firefox
echo -e "${WHITE}${line}"
echo -e "|                                |"
echo -e "| Installing Firefox              |"
echo -e "|                                |"
echo -e "${line}"
sudo apt install firefox

# Install Cloudflare WARP
echo -e "${WHITE}${line}"
echo -e "|                                |"
echo -e "| Installing Cloudflare WARP      |"
echo -e "|                                |"
echo -e "${line}"
sudo apt-get update
sudo apt-get install cloudflare-warp

# Install QEMU, libvirt, and related packages
echo -e "${WHITE}${line}"
echo -e "|                                |"
echo -e "| Installing QEMU and libvirt     |"
echo -e "|                                |"
echo -e "${line}"
sudo apt-get install qemu-kvm qemu-system qemu-utils python3 python3-pip libvirt-clients libvirt-daemon-system bridge-utils virtinst libvirt-daemon virt-manager -y

# Start and configure libvirt
echo -e "${WHITE}${line}"
echo -e "|                                |"
echo -e "| Configuring libvirt            |"
echo -e "|                                |"
echo -e "${line}"
sudo systemctl status libvirtd.service
sudo virsh net-start default
sudo virsh net-autostart default
sudo virsh net-list --all
sudo usermod -aG libvirt $USER
sudo usermod -aG libvirt-qemu $USER
sudo usermod -aG kvm $USER
sudo usermod -aG input $USER
sudo usermod -aG disk $USER

echo -e "${line}"
echo -e "|                                |"
echo -e "|${GREEN} Installed packages: $total_installed_packages ${NC}|"
echo -e "|                                |"
echo -e "${line}"

echo -e "${NC}" # Reset color
echo "All packages uninstalled, unnecessary files cleaned, and additional installations done."
read -p "Press Enter to exit."
