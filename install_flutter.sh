#!/bin/bash

# Check if Flutter is already installed
if [ -d "$HOME/flutter" ]; then
  echo "Flutter is already installed."
  exit 0
fi

# Navigate to the home folder
mkdir ~/development
cd ~/development

# Download and extract Flutter
wget https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.13.4-stable.tar.xz
tar xf flutter_linux_3.13.4-stable.tar.xz


# Add Flutter to your PATH in the .bashrc file
echo 'export PATH="$PATH:$HOME/isifat/development/flutter/bin"' >> $HOME/.bashrc
source $HOME/.bashrc

# Accept Android licenses
flutter doctor --android-licenses

# Clean up the downloaded archive
rm flutter_linux_3.13.3-stable.tar.xz

# Verify Flutter installation
flutter doctor

echo "Flutter has been successfully installed."
exit 0

