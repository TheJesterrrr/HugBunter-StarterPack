#!/bin/bash

# Melakukan check package dan upgrade
echo "Memperbarui paket sistem..."
sudo apt-get update && sudo apt-get upgrade -y

# Memeriksa apakah Go sudah terinstal
if command -v go &> /dev/null; then
    echo "Golang sudah terinstal dengan versi: $(go version)"
    
    read -p "Apakah Anda ingin menginstal ulang Golang? (Y/N): " reinstall_go
    reinstall_go_lower=$(echo "$reinstall_go" | tr '[:upper:]' '[:lower:]')
    
    if [[ "$reinstall_go_lower" == "yes" || "$reinstall_go_lower" == "y" ]]; then
        echo "Menginstal ulang Golang..."
        sudo apt-get install -y golang
        echo "Golang berhasil diinstal ulang!"
    else
        echo "Melewati instalasi Golang, menggunakan versi yang sudah ada."
    fi
else
    # Jika Go belum terinstal
    read -p "Golang belum terinstal. Apakah Anda ingin menginstal Golang? (Y/N): " install_go
    install_go_lower=$(echo "$install_go" | tr '[:upper:]' '[:lower:]')
    
    if [[ "$install_go_lower" == "yes" || "$install_go_lower" == "y" ]]; then
        echo "Menginstal Golang..."
        sudo apt-get install -y golang
        echo "Golang berhasil diinstal!"
    else
        echo "GO TIDAK TERPASANG!"
    fi
fi

echo -e "\n--- Melanjutkan ke instalasi Nuclei ---\n"

# Konfirmasi pemasangan Nuclei
read -p "Lanjut memasang Nuclei? (Y/N): " response
response_lower=$(echo "$response" | tr '[:upper:]' '[:lower:]')

if [[ "$response_lower" == "yes" || "$response_lower" == "y" ]]; then
    echo "Menginstal Nuclei..."
    
    
    if command -v go &> /dev/null; then
        go install -v github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest
        
        # PATH
        if [ -f "$HOME/go/bin/nuclei" ]; then
            echo 'export PATH=$PATH:$HOME/go/bin' >> ~/.bashrc
            source ~/.bashrc
            echo "Nuclei berhasil diinstal!"
            echo "Jalankan 'source ~/.bashrc' atau buka terminal baru untuk menggunakan nuclei."
        else
            echo "Gagal menginstal Nuclei. Pastikan Go terinstal dengan benar."
        fi
    else
        echo "ERROR: Go tidak ditemukan. Instal Go terlebih dahulu."
        echo "Instalasi Nuclei dibatalkan."
    fi
    
elif [[ "$response_lower" == "no" || "$response_lower" == "n" ]]; then
    echo "Instalasi Nuclei dibatalkan."
    echo "Proses selesai."
else
    echo "Input tidak valid! Instalasi Nuclei dibatalkan."
fi

echo "Skrip selesai dijalankan."