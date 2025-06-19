#!/usr/bin/env python3

import os
import platform
import shutil
import subprocess
import sys

from pyfiglet import Figlet
from rich.console import Console



if os.name == "nt":
    local_appdata = os.getenv("LOCALAPPDATA")
    if local_appdata is None:
        print("❌ LOCALAPPDATA environment variable is not set, please set LOCALAPPDATA as an environment variable and run the script again")
        input("Press Enter to Quit")
        sys.exit(1)

    NVIM_CONFIG_PATH = os.path.join(local_appdata, "nvim")
    NVIM_DATA_PATH = os.path.join(local_appdata, "nvim-data")
    NVIM_CACHE_PATH = os.path.join(local_appdata, "nvim-data", "site", "cache")
else:
    HOME = os.path.expanduser("~") 
    NVIM_CONFIG_PATH = os.path.join(HOME, ".config", "nvim")
    NVIM_DATA_PATH = os.path.join(HOME, ".local", "share", "nvim")
    NVIM_CACHE_PATH = os.path.join(HOME, ".cache", "nvim")

print('nvim Config Path : ',NVIM_CONFIG_PATH + "\n")
print('nvim DATA Path : ',NVIM_DATA_PATH)
print('nvim CACHE Path : ',NVIM_CACHE_PATH)
CURRENT_DIR = os.getcwd()
input('Press Enter Continue ')
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
    else:
        clean_old_config()

def clean_old_config():
    print()

    for path in [NVIM_CONFIG_PATH, NVIM_DATA_PATH]:
        if os.path.exists(path) or os.path.islink(path):
            print(f"🧹 Removing {path} ...")
            try:
                if os.name == 'nt':
                    # For symbolic links
                    if os.path.islink(path):
                        os.unlink(path)
                    # For directories with protected Git files (e.g. lazy.nvim)
                    elif os.path.isdir(path):
                        # Take ownership and grant permissions before deletion
                        run(f'takeown /f "{path}" /r /d Y', check=False)
                        run(f'icacls "{path}" /grant %USERNAME%:F /t', check=False)
                        run(f'rmdir /s /q "{path}"', check=False)
                    else:
                        os.remove(path)
                else:
                    # Unix-like systems
                    if os.path.islink(path):
                        os.unlink(path)
                    else:
                        shutil.rmtree(path, ignore_errors=True)

            except Exception as e:
                print(f"❌ Failed to remove {path}: {e}")


def install_dependencies():
    os_type = platform.system()
    print(f"\n🛠 Installing dependencies for {os_type}...\n")

    if os_type == "Linux":
        if is_command_available("apt"):
            run("sudo apt update")
            run("sudo apt install -y neovim git curl ripgrep fd-find gcc")
        elif is_command_available("pacman"):
            run("sudo pacman -Syu --noconfirm")
            run("sudo pacman -S --noconfirm neovim git curl ripgrep fd gcc")
        else:
            print("Unsupported Linux package manager.")
            sys.exit(1)

    elif os_type == "Darwin":
        if not is_command_available("brew"):
            print("🍺 Homebrew not found. Install it from https://brew.sh first.")
            sys.exit(1)
        run("brew install neovim git curl ripgrep fd gcc")

    elif os_type == "Windows":
        if not is_windows_admin():
            print("❌ This script must be run as Administrator on Windows.")
            print("➡️ Right-click PowerShell or CMD and choose 'Run as Administrator', then run this script again.")
            sys.exit(1)

        if is_command_available("choco"):
            run("choco install -y neovim git curl ripgrep")

        elif is_command_available("scoop"):
            run("scoop install neovim git curl ripgrep")
        else:
            print("❌ No supported package manager found (choco or scoop).")
            print("➡️ Please install dependencies manually or install Chocolatey from:")
            print("   https://chocolatey.org/install")
            sys.exit(1)

    else:
        print(f"Unsupported OS: {os_type}")
        sys.exit(1)

def install_python_support():
    run("pip3 install --user pynvim")
    
def is_windows_admin():
    if os.name != 'nt':
        return False
    try:
        import ctypes
        return ctypes.windll.shell32.IsUserAnAdmin()
    except Exception:
        return False


def link_config():
    print("\n🔗 Linking cloned config to ~/.config/nvim ...")
    config_parent = os.path.dirname(NVIM_CONFIG_PATH)
    os.makedirs(config_parent, exist_ok=True)

    if os.path.exists(NVIM_CONFIG_PATH) or os.path.islink(NVIM_CONFIG_PATH):
        print(f"🔁 Removing existing config at {NVIM_CONFIG_PATH} ...")
        try:
            if os.path.islink(NVIM_CONFIG_PATH):
                os.unlink(NVIM_CONFIG_PATH)
            else:
                shutil.rmtree(NVIM_CONFIG_PATH)
        except Exception as e:
            print(f"❌ Failed to remove old config: {e}")
            sys.exit(1)

    try:
        if os.name == 'nt':
            # Create junction (safe on all Windows setups)
            print("🔗 Creating junction (Windows)...")
            run(f'mklink /J "{NVIM_CONFIG_PATH}" "{CURRENT_DIR}"')
        else:
            # Safe on Linux/macOS
            print("🔗 Creating symlink (Unix)...")
            os.symlink(CURRENT_DIR, NVIM_CONFIG_PATH)

        print("✅ Link created successfully.")

    except Exception as e:
        print(f"❌ Failed to create link: {e}")
        sys.exit(1)



def install_lazy_nvim():
    lazy_path = os.path.expanduser("~\\AppData\\Local\\nvim-data\\lazy\\lazy.nvim")

    print(f"🔄 Reinstalling lazy.nvim...")

    # Windows needs shell removal due to permissions/depth issues
    if os.name == 'nt':
        run(f'rmdir /s /q "{lazy_path}"', check=False)
    else:
        shutil.rmtree(lazy_path, ignore_errors=True)

    run("git clone https://github.com/folke/lazy.nvim \"" + lazy_path + "\"")


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
        run('powershell.exe -NoExit -Command "nvim +\\"Lazy sync\\""', check=False)

    else:
        print("❌ Unsupported OS. Please run: `nvim +Lazy sync` manually.")


def validate_repo_structure():
    if not os.path.isfile(REPO_EXPECTED_FILE) or not os.path.isdir(REPO_LUA_DIR) or not os.path.isfile(REPO_INIT_LUA):
        print("❌ Error: This script must be run from the root of your cloned NeoVim config repo.")
        sys.exit(1)

def welcome():

    console = Console()
    f = Figlet(font="ansi_shadow")  # Terminal Formatting!  dotmatrix
    ff = Figlet(font = "speed") 

    ascii_art_name = ff.renderText("Amir's")
    ascii_art = f.renderText("EASYNVIM")
    
    console.print(ascii_art_name, style="bold red")
    console.print(ascii_art, style="bold yellow")
    
    
    
    console.print(
    "[bold cyan]This installation process is designed to be as automated as possible,[/bold cyan] "
    "[bold cyan]requiring minimal user input.[/bold cyan]\n\n"
    
    "[yellow]However, you will be prompted to confirm certain steps when necessary.[/yellow]\n\n"
    
    "[bold red]Note for Windows users:[/bold red]\n"
    "[green]- You may need to manually restart PowerShell.[/green]\n"
    "[green]- You may also need to launch Neovim for the first time manually.[/green]\n\n"
    
    "[bold yellow]If prompted, simply follow the on-screen instructions.[/bold yellow]\n"
)

    if (input('press any key to continue OR "Q" to Quit the installation\n').strip().lower()) == "q":
        sys.exit(0)
      

def main():
    welcome()
    validate_repo_structure()
    prompt_user()
  
    install_dependencies()
    install_python_support()
    link_config()
    install_lazy_nvim()
    
    if shutil.which("nvim") is None:
        print("\n⚠️  'nvim' not found in PATH.")
        print("➡️  This may happen if NeoVim was just installed.")
        print("🔁 Please restart PowerShell or run manually:\n")
        print('    nvim +"Lazy sync"\n')
    else:
        launch_nvim_terminal()

        print("\n✅ NeoVim setup is complete!")

        print("\n✅ Neovim is fully installed and ready to use!\n")

if __name__ == "__main__":
    main()
