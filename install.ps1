
# install.ps1
$ErrorActionPreference = "Stop"

function Ensure-Admin {
    if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
        Write-Host "⏫ Relaunching as Administrator..."
        Start-Process powershell.exe "-ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
        exit
    }
}

Ensure-Admin

if (-not (Get-Command "pip" -ErrorAction SilentlyContinue)) {
    Write-Error "`n[ERROR] pip is not installed or not in PATH. Please install Python (https://python.org) and try again."
    exit 1
}

Write-Host "`n[+] Installing Python dependencies: pyfiglet, rich"
pip install pyfiglet rich

Write-Host "`n[+] Running the NeoVim installer..."
python nvim_install.py
