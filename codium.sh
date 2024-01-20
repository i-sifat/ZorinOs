#!/bin/bash

# Define the Codium download URL
CODIUM_URL="https://github.com/VSCodium/vscodium/releases/download/1.85.2.24019/codium_1.85.2.24019_amd64.deb"

# Define the temporary download location
TEMP_DOWNLOAD_DIR="/tmp/codium_download"

# Create a temporary directory for download
mkdir -p "$TEMP_DOWNLOAD_DIR"

# Navigate to the temporary directory
cd "$TEMP_DOWNLOAD_DIR"

# Download the Codium .deb package
wget "$CODIUM_URL"

# Install Codium from the downloaded .deb package
sudo dpkg -i codium_1.85.2.24019_amd64.deb

# Install dependencies
sudo apt-get install -f

# Clean up temporary files
rm -rf "$TEMP_DOWNLOAD_DIR"

echo "VSCodium has been installed successfully."

