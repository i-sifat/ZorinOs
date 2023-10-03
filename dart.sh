#!/bin/bash

# Update the package lists
sudo apt-get update

# Install the apt-transport-https package
sudo apt-get install apt-transport-https

# Download and install the Dart signing key
wget -qO- https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo gpg --dearmor -o /usr/share/keyrings/dart.gpg

# Add the Dart repository to the sources list
echo 'deb [signed-by=/usr/share/keyrings/dart.gpg arch=amd64] https://storage.googleapis.com/download.dartlang.org/linux/debian stable main' | sudo tee /etc/apt/sources.list.d/dart_stable.list

# Update the package lists again to include the Dart repository
sudo apt-get update

# Install Dart
sudo apt-get install dart
 echo 'export PATH="$PATH:/usr/lib/dart/bin"' >> ~/.profile

