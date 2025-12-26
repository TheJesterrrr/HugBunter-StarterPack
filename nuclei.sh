#!/bin/bash 

# Melakukan check package dan upgrade
sudo apt-get update && sudo apt-get upgrade -y

# menginstall Golang
sudo apt-get install -y golang

# konfirmasi pemasangan Nuclei
read -p "Lanjut memasang Nuclei? (Y/N): " response
response_lower=$(echo "$response" | tr '[:upper:]' '[:lower:]')
if [[ "$response_lower" == "yes" || "$response_lower" == "y" ]]; then
    echo "Menginstal package..."
    go install -v github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest
    echo 'export PATH=$PATH:$HOME/go/bin' >> ~/.bashrc && source ~/.bashrc
    echo "Package berhasil diinstal!"
elif [[ "$response_lower" == "no" || "$response_lower" == "n" ]]; then
    echo "Instalasi dibatalkan"
    exit 1
else
    echo "Input tidak valid!"
    exit 1
    fi


