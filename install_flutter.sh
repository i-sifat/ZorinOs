#!/bin/bash

# Check if Flutter is already installed
if [ -d "$HOME/development/flutter" ]; then
  echo "Flutter is already installed."
  exit 0
fi

# Create a development directory and navigate to it
mkdir -p ~/development
cd ~/development

# Download and extract Flutter
wget https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.13.3-stable.tar.xz
tar xf flutter_linux_3.13.3-stable.tar.xz

# Add Flutter to your PATH
export PATH="$PATH:$HOME/development/flutter/bin"

# Accept Android licenses
flutter doctor --android-licenses

# Clean up the downloaded archive
rm flutter_linux_3.13.3-stable.tar.xz

# Verify Flutter installation
flutter doctor

echo "Flutter has been successfully installed."
exit 0

