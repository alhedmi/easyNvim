#!/usr/bin/env bash

set -e

echo "[+] Checking for pip3..."
if ! command -v pip3 &> /dev/null; then
    echo "[!] pip3 not found. Please install Python 3 and pip before running this script."
    exit 1
fi

# Use a user-space directory for the virtual environment
VENV_DIR="./install_venv"

echo "[+] Creating Python environment in $VENV_DIR"
python3 -m venv "$VENV_DIR"

echo "[+] Activating virtual environment"
# shellcheck disable=SC1091
source "$VENV_DIR/bin/activate"

echo "[+] Installing Python dependencies: pyfiglet, rich"
pip install pyfiglet rich

echo "[+] Running the NeoVim installer..."
python nvim_install.py
