#!/bin/bash

# This script installs the latest Visual Studio Code installer for Linux Ubuntu.

# Check if Visual Studio Code is already installed.
if [ -f "/usr/bin/code" ]; then
  echo "Visual Studio Code is already installed."
  exit 0
fi

# Download the Visual Studio Code installer.
wget https://code.visualstudio.com/download/linux/latest

# Extract the Visual Studio Code installer.
tar -xzvf code-linux-x64-latest.tar.gz

# Move the Visual Studio Code binary to the /usr/bin directory.
sudo mv code-linux-x64/code /usr/bin/code

# Create a desktop launcher for Visual Studio Code.
echo "[Desktop Entry]" > code.desktop
echo "Name=Visual Studio Code" >> code.desktop
echo "GenericName=Code Editor" >> code.desktop
echo "Comment=Code editing. Redefined." >> code.desktop
echo "Exec=/usr/bin/code" >> code.desktop
echo "Terminal=false" >> code.desktop
echo "Type=Application" >> code.desktop
echo "Icon=/usr/bin/code" >> code.desktop
echo "Categories=Development;IDE;" >> code.desktop
echo "StartupNotify=false" >> code.desktop

# Install the desktop launcher.
sudo cp code.desktop /usr/share/applications/code.desktop
