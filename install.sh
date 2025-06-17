
#!/usr/bin/env bash

set -e

echo "[+] Checking for pip3..."
if ! command -v pip3 &> /dev/null; then
    echo "[!] pip3 not found. Please install Python 3 and pip before running this script."
    exit 1
fi

echo "[+] Installing Python dependencies: pyfiglet, rich"
pip3 install --user pyfiglet rich

echo "[+] Running the NeoVim installer..."
python3 nvim_install.py
