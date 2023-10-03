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

echo -e "${line}"
echo -e "|                                |"
echo -e "|${GREEN} Installed packages: $total_installed_packages ${NC}|"
echo -e "|                                |"
echo -e "${line}"

echo -e "${NC}" # Reset color
echo "All packages uninstalled, unnecessary files cleaned, and additional installations done."
read -p "Press Enter to exit."
