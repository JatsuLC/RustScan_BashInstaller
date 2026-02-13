#!/bin/bash

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Check if running as root
if [[ $EUID -ne 0 ]]; then
    print_error "This script must be run as root (use sudo)"
    exit 1
fi

echo -e "${GREEN}RustScan Installer${NC}"
echo ""
echo "Installing Rustscan..."
LATEST=$(curl -s https://api.github.com/repos/bee-san/RustScan/releases/latest | grep "tag_name" | cut -d '"' -f 4)
echo -e "Installing version: $LATEST"
wget -q --show-progress "https://github.com/bee-san/RustScan/releases/download/$LATEST/rustscan.deb.zip" -O /tmp/rustscan.deb.zip
7z e /tmp/rustscan.deb.zip -o/tmp/Extractedrustscan
debFile=$(ls /tmp/Extractedrustscan/ | grep $LATEST)
echo "Installing..."
sudo dpkg -i /tmp/Extractedrustscan/$debFile
echo -e "${GREEN}Installing success!${NC}"
echo "Cleaning up"
sudo rm -rf /tmp/Extractedrustscan
sudo rm /tmp/rustscan.deb.zip

rustscan --version
