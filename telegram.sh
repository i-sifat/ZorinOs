#!/bin/bash

# This script installs Telegram on Linux Ubuntu.

# Check if Telegram is already installed.
if [ -f "/usr/bin/telegram-desktop" ]; then
  echo "Telegram is already installed."
  exit 0
fi

# Download the Telegram installer.
wget https://tdesktop.com/linux

# Extract the Telegram installer.
tar -xzvf telegram-linux

# Move the Telegram binary to the /usr/bin directory.
sudo mv telegram-linux/Telegram /usr/bin/telegram-desktop

# Create a desktop launcher for Telegram.
echo "[Desktop Entry]" > telegram.desktop
echo "Name=Telegram" >> telegram.desktop
echo "GenericName=Chat" >> telegram.desktop
echo "Comment=Chat with your friends" >> telegram.desktop
echo "Exec=/usr/bin/telegram-desktop" >> telegram.desktop
echo "Terminal=false" >> telegram.desktop
echo "Type=Application" >> telegram.desktop
echo "Icon=/usr/bin/telegram-desktop" >> telegram.desktop
echo "Categories=Network;Chat;" >> telegram.desktop
echo "StartupNotify=false" >> telegram.desktop

# Install the desktop launcher.
sudo cp telegram.desktop /usr/share/applications/telegram.desktop
