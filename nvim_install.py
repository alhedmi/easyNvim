#!/usr/bin/env python3

import os
import platform
import shutil
import subprocess
import sys

HOME = os.path.expanduser("~")
NVIM_CONFIG_PATH = os.path.join(HOME, ".config", "nvim")
NVIM_DATA_PATH = os.path.join(HOME, ".local", "share", "nvim")
NVIM_CACHE_PATH = os.path.join(HOME, ".cache", "nvim")
CURRENT_DIR = os.getcwd()

REPO_EXPECTED_FILE = os.path.join(CURRENT_DIR, "nvim_install.py")
REPO_LUA_DIR = os.path.join(CURRENT_DIR, "lua")
REPO_INIT_LUA = os.path.join(CURRENT_DIR, "init.lua")

def run(cmd, check=True):
    print(f"\033[94m[RUN]\033[0m {cmd}")
    subprocess.run(cmd, shell=True, check=check)

def is_command_available(cmd):
    return shutil.which(cmd) is not None


def nvim_config_exists():
    return any(os.path.exists(p) for p in [NVIM_CONFIG_PATH, NVIM_DATA_PATH, NVIM_CACHE_PATH])

def nvim_installed():
    return is_command_available("nvim")


def prompt_user():
    if not nvim_config_exists() and not nvim_installed():
        print("ℹ️  No existing Neovim installation detected. Proceeding with fresh setup.\n")
        return  # No need to warn — clean install

    print("⚠️  \033[91mWARNING\033[0m: Existing Neovim config or installation detected.")
    print("Running this script may DELETE your current Neovim setup, including:")
    if os.path.exists(NVIM_CONFIG_PATH):
        print(f"  - {NVIM_CONFIG_PATH}")
    if os.path.exists(NVIM_DATA_PATH):
        print(f"  - {NVIM_DATA_PATH}")
    if os.path.exists(NVIM_CACHE_PATH):
        print(f"  - {NVIM_CACHE_PATH}")
    if nvim_installed():
        print("  - System-installed Neovim (will not be auto-removed unless you're on Ubuntu or Arch)")

    print("\n💡 To back up your current setup, run the following commands:")
    print(f"""
    mkdir -p ~/nvim_backup
    cp -r {NVIM_CONFIG_PATH} ~/nvim_backup/
    cp -r {NVIM_DATA_PATH} ~/nvim_backup/
    cp -r {NVIM_CACHE_PATH} ~/nvim_backup/
    """)
    
    choice = input("❓ Continue with installation and remove old config? (yes/no): ").strip().lower()
    if choice != "yes":
        print("🚫 Installation aborted.")
        sys.exit(0)
    else
        clean_old_config()

def clean_old_config():
    for path in [NVIM_CONFIG_PATH, NVIM_DATA_PATH, NVIM_CACHE_PATH]:
        if os.path.exists(path):
            print(f"🧹 Removing {path} ...")
            shutil.rmtree(path)

def install_dependencies():
    os_type = platform.system()
    print(f"\n🛠 Installing dependencies for {os_type}...\n")
    
    if os_type == "Linux":
        if is_command_available("apt"):
            run("sudo apt update")
            run("sudo apt install -y neovim git curl ripgrep fd-find python3-pip gcc")
        elif is_command_available("pacman"):
            run("sudo pacman -Syu --noconfirm")
            run("sudo pacman -S --noconfirm neovim git curl ripgrep fd python-pip gcc")
        else:
            print("Unsupported Linux package manager.")
            sys.exit(1)
    elif os_type == "Darwin":
        if not is_command_available("brew"):
            print("🍺 Homebrew not found. Install it from https://brew.sh first.")
            sys.exit(1)
        run("brew install neovim git curl ripgrep fd python3 gcc")
    else:
        print(f"Unsupported OS: {os_type}")
        sys.exit(1)

def install_python_support():
    run("pip3 install --user pynvim")

def link_config():
    print("\n🔗 Linking cloned config to ~/.config/nvim ...")
    os.makedirs(os.path.dirname(NVIM_CONFIG_PATH), exist_ok=True)
    os.symlink(CURRENT_DIR, NVIM_CONFIG_PATH)

def install_lazy_nvim():
    lazy_path = os.path.expanduser("~/.local/share/nvim/site/pack/lazy/start/lazy.nvim")
    if not os.path.exists(lazy_path):
        print("⬇️  Installing lazy.nvim plugin manager...")
        run("git clone https://github.com/folke/lazy.nvim " + lazy_path)

def launch_nvim_terminal():
    print("\n🚀 Opening NeoVim in a new terminal window to install plugins...")

    os_type = platform.system()

    if os_type == "Linux":
        term_cmds = [
            "gnome-terminal -- bash -c 'nvim +\"Lazy sync\" || read -p \"Unexpected Error, Press enter to close...\"'",
            "konsole -e bash -c 'nvim +\"Lazy sync\" || read -p \"Unexpected Error, Press enter to close...\"'",
            "xfce4-terminal -e 'bash -c \"nvim +\\\"Lazy sync\\\" || read -p \\\"Unexpected Error, Press enter to close...\\\"\"'",
            "xterm -e bash -c 'nvim +\"Lazy sync\" || read -p \"Unexpected Error, Press enter to close...\"'"
        ]
        for cmd in term_cmds:
            try:
                run(cmd)
                return
            except Exception:
                continue
        print("❌ Could not open a terminal. Please run manually: `nvim +Lazy sync`")

    elif os_type == "Darwin":  # macOS
        script = '''
        tell application "Terminal"
            do script "nvim +\\"Lazy sync\\" || read -p \\"Unexpected Error, Press enter to close...\\""
            activate
        end tell
        '''
        run(f"osascript -e '{script}'")

    elif os_type == "Windows":
        run('start powershell -NoExit nvim +"Lazy sync"', check=False)

    else:
        print("❌ Unsupported OS. Please run: `nvim +Lazy sync` manually.")


def validate_repo_structure():
    if not os.path.isfile(REPO_EXPECTED_FILE) or not os.path.isdir(REPO_LUA_DIR) or not os.path.isfile(REPO_INIT_LUA):
        print("❌ Error: This script must be run from the root of your cloned NeoVim config repo.")
        sys.exit(1)

def main():
    validate_repo_structure()
    prompt_user()
  
    install_dependencies()
    install_python_support()
    link_config()
    install_lazy_nvim()
    launch_nvim_terminal()
    print("\n✅ Neovim is fully installed and ready to use!\n")

if __name__ == "__main__":
    main()
