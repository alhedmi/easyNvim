#  EasyNvim

**_Note_**: ``This repo is still under development and you may run into issues, if so please let me know about them or create an issue/pull request``

--------------------------------------
Custom NeoVim configuration with minimal installation steps and focus on ease-of-use, speed, and modern UI features.


## 🔑 easyNvim Keymaps and commands

<!----easynvim_tips_start-->
| Keymap         | Mode | Description                                                |
|----------------|------|------------------------------------------------------------|
| `jj`           | i    | Exit insert mode (maps to `<Esc>`)                         |
| `<leader>t`    | n    | Open terminal in a new tab                                 |
| `<leader>tc`   | n    | Close the current tab                                      |
| `<Tab>`        | n    | Cycle to the next buffer (BufferLine)                      |
| `<S-Tab>`      | n    | Cycle to the previous buffer                               |
| `<leader>cd`   | n    | Copy the current file’s directory to clipboard             |
| `<leader>..`   | n    | Open the easyNvim help file in a split view                |
| `<leader>.-`   | n    | Open the help file (`README.md`) in the browser preview    |
| `<leader>h`    | n    | Open a new tab and show the dashboard                      |
| `:SessionRestore` | cmd | Restore the last saved session manually                  |
| `:Q`           | cmd  | Safe quit — prevents exiting if there are unsaved buffers  |
<!----easynvim_tips_end-->

---

##  Installation Guide

###  Requirements
Before you begin, make sure you have:

- Python 3.x (`python3` or `py` command)
- pip
- Git
- [Chocolatey](https://docs.chocolatey.org) or scoop to install NeoVim if you havent already installed it.
---

###  Step-by-step

#### 1. Clone this repository
```bash
git clone https://github.com/alhedmi/easyNvim.git
cd easyNvim
```

#### 2. Run the install script

#####  Linux / macOS
```
./install.sh
```

##### Windows (️ Run PowerShell as Administrator)
```powershell
install.ps1 
```
>  On Windows, right-click PowerShell or CMD and choose **"Run as Administrator"**  
> to avoid permission issues when linking the config folder or installing packages.

---

###  What This Script Does

- Installs all dependencies (Neovim, pip packages, etc.)
- Links this repo to your Neovim config folder
- Installs [`lazy.nvim`](https://github.com/folke/lazy.nvim) and essential plugins
- Launches Neovim to sync everything

---

###  Backing up your old Neovim config (optional)
If you already have a Neovim setup, it’s smart to back it up first:

```bash
mkdir -p ~/nvim_backup
cp -r ~/.config/nvim ~/nvim_backup/
cp -r ~/.local/share/nvim ~/nvim_backup/
cp -r ~/.cache/nvim ~/nvim_backup/
```

---

###  First launch

Once the install finishes:
```bash
nvim
```

Inside Neovim, wait for `lazy.nvim` to finish installing plugins.  
Then enjoy your custom setup with:

- `<leader>h` → Dashboard
- `<leader>..` → In-editor help
- `<leader>t` → Terminal tab

---

##  Credits & License 
```
Made by Amir Alhedmi  
MIT License
```
