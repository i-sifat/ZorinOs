#!/bin/bash

# Create a directory for downloads in ~/Downloads
mkdir -p ~/Downloads/
cd ~/Downloads/

# Download Motrix
wget https://dl.motrix.app/release/Motrix_1.8.19_amd64.deb

# Install Motrix
sudo apt install ./Motrix_1.8.19_amd64.deb

# Remove the downloaded .deb file
rm Motrix_1.8.19_amd64.deb

echo "Motrix Download Manager has been installed."

// chmod +x motrix.sh
// sudo ./motrix.sh
