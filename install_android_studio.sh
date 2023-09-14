#!/bin/bash

# Function to display messages
print_message() {
  echo -e "${WHITE}${line}"
  echo -e "|                                |"
  echo -e "| $1"
  echo -e "|                                |"
  echo -e "${line}"
}

# Define variables
WHITE="\033[1;37m"
line="=================================="

# Print installation message
print_message "Installing Android Studio"

# Create a directory for Android Studio in ~/development
mkdir -p ~/development/android-studio
cd ~/development/android-studio

# Download and extract Android Studio
wget https://redirector.gvt1.com/edgedl/android/studio/ide-zips/2022.3.1.19/android-studio-2022.3.1.19-linux.tar.gz
tar -xzf android-studio-2022.3.1.19-linux.tar.gz

# Move Android Studio to /opt/
sudo mv android-studio /opt/

# Run Android Studio
/opt/android-studio/bin/studio.sh

# Create a desktop shortcut (Optional)
cat > ~/.local/share/applications/android-studio.desktop <<EOL
[Desktop Entry]
Name=Android Studio
Comment=Android IDE
Exec=/opt/android-studio/bin/studio.sh
Icon=/opt/android-studio/bin/studio.png
Terminal=false
Type=Application
Categories=Development;IDE;
EOL

# Update the desktop database
update-desktop-database ~/.local/share/applications/

echo "Android Studio has been installed."

