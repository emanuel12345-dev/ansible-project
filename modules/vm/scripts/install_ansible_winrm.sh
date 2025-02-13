#!/bin/bash
set -e

echo "=== Updating package repositories ==="
sudo apt-get update -y

echo "=== Installing Python 3, pip3, and venv ==="
sudo apt-get install -y python3 python3-pip python3-venv

echo "=== Upgrading pip3 to the latest version ==="
sudo pip3 install --upgrade pip

echo "=== Installing Ansible ==="
# This installs the latest version of Ansible compatible with Python 3.
sudo pip3 install ansible

echo "=== Installing pywinrm (for WinRM connectivity) ==="
sudo pip3 install pywinrm

echo "=== Installation completed successfully ==="
