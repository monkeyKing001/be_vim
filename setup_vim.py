#!/usr/bin/env python3

import os
import shutil
import subprocess
import platform

def is_installed(command):
    """Check if a command is available on the system."""
    return shutil.which(command) is not None

def install_system_lib():
    system = platform.system()
    if system == "Darwin":  # macOS
        print("Installing system libraries for macOS...")
        dependencies = ["vim", "curl", "git", "brew"]
        for dep in dependencies:
            if not is_installed(dep):
                if dep == "brew":
                    print("Installing Homebrew...")
                    subprocess.run(
                        '/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"',
                        shell=True,
                        check=True,
                    )
                else:
                    print(f"Installing {dep} with Homebrew...")
                    subprocess.run(["brew", "install", dep], check=True)
    elif system == "Linux":
        print("Installing system libraries for Linux...")
        dependencies = ["sudo", "vim", "curl", "git", "software-properties-common"]
        for dep in dependencies:
            if not is_installed(dep):
                print(f"Installing {dep} with apt...")
                subprocess.run(["sudo", "apt-get", "install", "-y", dep], check=True)
    else:
        print(f"Unsupported OS: {system}. Exiting.")
        exit(1)

def install_nodejs_LTS():
    if not is_installed("node"):
        system = platform.system()
        if system == "Darwin":  # macOS
            print("Installing Node.js LTS for macOS...")
            subprocess.run(["brew", "install", "node@lts"], check=True)
        elif system == "Linux":  # Linux
            print("Installing Node.js LTS for Linux...")
            subprocess.run(
                'curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -',
                shell=True,
                check=True,
            )
            subprocess.run(["sudo", "apt-get", "install", "-y", "nodejs"], check=True)
        else:
            print(f"Unsupported OS: {system}. Exiting.")
            exit(1)
    else:
        print("Node.js is already installed.")

def install_neovim_latest():
    if not is_installed("nvim"):
        system = platform.system()
        if system == "Darwin":  # macOS
            print("Installing Neovim for macOS...")
            subprocess.run(["brew", "install", "--HEAD", "neovim"], check=True)
        elif system == "Linux":  # Linux
            print("Installing Neovim for Linux...")
            subprocess.run(["sudo", "add-apt-repository", "ppa:neovim-ppa/unstable", "-y"], check=True)
            subprocess.run(["sudo", "apt-get", "update", "-y"], check=True)
            subprocess.run(["sudo", "apt-get", "install", "-y", "neovim"], check=True)
        else:
            print(f"Unsupported OS: {system}. Exiting.")
            exit(1)
    else:
        print("Neovim is already installed.")

def install_dependencies():
    install_system_lib()
    install_nodejs_LTS()
    install_neovim_latest()

#########################
#      Get Vim Plug     #
#########################

def download_files():
    plug_vim_url = "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
    nvim_init_url = "https://raw.githubusercontent.com/monkeyKing001/be_vim/main/init.vim"
    vimrc_url = "https://raw.githubusercontent.com/monkeyKing001/be_vim/main/.vimrc"

    home_dir = os.path.expanduser("~")
    nvim_config_dir = os.path.join(home_dir, ".config", "nvim")
    nvim_autoload_dir = os.path.join(home_dir, ".local", "share", "nvim", "site", "autoload")
    plug_vim_path = os.path.join(nvim_autoload_dir, "plug.vim")
    init_vim_path = os.path.join(nvim_config_dir, "init.vim")
    vimrc_path = os.path.join(home_dir, ".vimrc")

    os.makedirs(nvim_config_dir, exist_ok=True)
    os.makedirs(nvim_autoload_dir, exist_ok=True)

    print("Downloading plug.vim...")
    urllib.request.urlretrieve(plug_vim_url, plug_vim_path)

    print("Downloading init.vim...")
    urllib.request.urlretrieve(nvim_init_url, init_vim_path)

    print("Downloading .vimrc...")
    urllib.request.urlretrieve(vimrc_url, vimrc_path)

#########################
#      Add Alias        #
#########################

def add_alias():
    home_dir = os.path.expanduser("~")
    system = platform.system()
    shell_rc = os.path.join(home_dir, ".zshrc" if system == "Darwin" else ".bashrc")

    alias_command = 'alias vim="nvim"'
    if os.path.exists(shell_rc):
        with open(shell_rc, "r") as file:
            if alias_command in file.read():
                print(f"Alias already exists in {shell_rc}.")
                return
    with open(shell_rc, "a") as file:
        file.write(f"\n# Alias for Neovim\n{alias_command}\n")
    print(f"Added alias to {shell_rc}.")

def main():
    install_dependencies()
    download_files()
    add_alias()

if __name__ == "__main__":
    main()
