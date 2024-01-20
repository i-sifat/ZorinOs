#!/bin/bash

# Check if Flutter is already installed
if [ -d "$HOME/development/flutter" ]; then
  echo "Flutter is already installed."
  exit 0
fi

# Navigate to the home folder
mkdir -p "$HOME/development"
cd "$HOME/development"

# Download and extract Flutter
FLUTTER_VERSION="3.16.8"
FLUTTER_URL="https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz"

wget "$FLUTTER_URL"
tar xf "flutter_linux_${FLUTTER_VERSION}-stable.tar.xz"

# Add Flutter to your PATH in the .bashrc file
echo 'export PATH="$PATH:$HOME/development/flutter/bin"' >> "$HOME/.bashrc"
source "$HOME/.bashrc"

# Accept Android licenses
flutter doctor --android-licenses
flutter precache


# Clean up the downloaded archive
rm "flutter_linux_${FLUTTER_VERSION}-stable.tar.xz"

# Verify Flutter installation
flutter doctor

echo "Flutter has been successfully installed."
exit 0
