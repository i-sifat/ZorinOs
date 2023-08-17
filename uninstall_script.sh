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

# Install WhiteSur GTK theme
echo -e "${WHITE}${line}"
echo -e "|                                |"
echo -e "| Installing WhiteSur GTK theme   |"
echo -e "|                                |"
echo -e "${line}"
git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git --depth=1
cd WhiteSur-gtk-theme
./install.sh
cd ..
rm -rf WhiteSur-gtk-theme

# Install WhiteSur icon theme
echo -e "${WHITE}${line}"
echo -e "|                                |"
echo -e "| Installing WhiteSur icon theme |"
echo -e "|                                |"
echo -e "${line}"
git clone https://github.com/vinceliuice/WhiteSur-icon-theme.git --depth=1
cd WhiteSur-icon-theme
./install.sh
cd ..
rm -rf WhiteSur-icon-theme

# Install Brave browser
echo -e "${WHITE}${line}"
echo -e "|                                |"
echo -e "| Installing Brave browser        |"
echo -e "|                                |"
echo -e "${line}"
sudo apt install curl
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update
sudo apt install brave-browser

# Install snap
if ! (which snap) 2>/dev/null; then
    echo -e "${WHITE}${line}"
    echo -e "|                                |"
    echo -e "| Installing Snap                |"
    echo -e "|                                |"
    echo -e "${line}"
    sudo apt install snapd
fi

# Install snap packages
echo -e "${WHITE}${line}"
echo -e "|                                |"
echo -e "| Installing Snap packages       |"
echo -e "|                                |"
echo -e "${line}"
sudo snap install wps-2019-snap
sudo snap install flutter --classic
sudo snap install code --classic
sudo snap install telegram-desktop

# Disable and stop services
echo -e "${WHITE}${line}"
echo -e "|                                |"
echo -e "| Disabling and stopping services|"
echo -e "|                                |"
echo -e "${line}"
sudo systemctl disable snapd.service
sudo systemctl stop systemd-networkd.service
sudo systemctl disable systemd-networkd.service

echo -e "${line}"
echo -e "|                                |"
echo -e "|${GREEN} Installed packages: $total_installed_packages ${NC}|"
echo -e "|                                |"
echo -e "${line}"

echo -e "${NC}" # Reset color
echo "All packages uninstalled, unnecessary files cleaned, and additional installations done."
read -p "Press Enter to exit."
