#!/bin/bash

# Function to check if a user is already in a group
is_user_in_group() {
  local user="$1"
  local group="$2"
  groups "$user" | grep -q "\b$group\b"
}

echo "Configuring libvirt..."

# Check if libvirtd.service is running
if sudo systemctl is-active --quiet libvirtd.service; then
  echo "libvirtd.service is already running."
else
  # Start libvirtd.service
  echo "Starting libvirtd.service..."
  sudo systemctl start libvirtd.service
fi

# Create a variable for your username
USER_NAME="$USER"

# Check and add the user to the necessary groups
groups=("libvirt" "libvirt-qemu" "kvm" "input" "disk")
for group in "${groups[@]}"; do
  if ! is_user_in_group "$USER_NAME" "$group"; then
    echo "Adding $USER_NAME to the $group group..."
    sudo usermod -aG "$group" "$USER_NAME"
  else
    echo "$USER_NAME is already a member of the $group group."
  fi
done

# Install required packages
echo "Installing required packages..."
sudo apt-get update
sudo apt-get install -y qemu-kvm qemu-system qemu-utils python3 python3-pip libvirt-clients libvirt-daemon-system bridge-utils virtinst libvirt-daemon virt-manager

# Start and configure the default libvirt network
echo "Starting and configuring the default libvirt network..."
sudo virsh net-start default
sudo virsh net-autostart default
sudo virsh net-list --all

echo "Libvirt has been configured."

# Optional: Display the status of libvirtd.service
sudo systemctl status libvirtd.service
