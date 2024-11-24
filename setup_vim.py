#!/usr/local/bin/ python3

import os
import shutil
import subprocess
import urllib.request
import platform
import json
from termcolor import colored

def test():
    print("hello")

def print_starting(package_name):
    print(colored(f"Starting installation of {package_name}...", "green"))

def print_success(package_name):
    print(colored(f"Successfully installed {package_name}.", "green"))

def print_error(package_name, error_msg):
    print(colored(f"Failed to install {package_name}: {error_msg}", "red"))

def is_installed(command):
    """Check if a command is available on the system."""
    return shutil.which(command) is not None

def install_package(package_name, install_command):
    try:
        print_starting(package_name)
        subprocess.run(install_command, shell=True, check=True)
        print_success(package_name)
    except subprocess.CalledProcessError as e:
        print_error(package_name, str(e))

def install_system_lib():
    system = platform.system()
    if system == "Darwin":  # macOS
        print("Installing system libraries for macOS...")
        dependencies = ["vim", "curl", "git", "brew"]
        for dep in dependencies:
            if not is_installed(dep):
                if dep == "brew":
                    install_package("Homebrew", '/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"')
                else:
                    install_package(dep, f"brew install {dep}")
    elif system == "Linux":
        print("Installing system libraries for Linux...")
        dependencies = ["sudo", "vim", "curl", "git", "software-properties-common"]
        for dep in dependencies:
            if not is_installed(dep):
                install_package(dep, f"sudo apt-get install -y {dep}")
    else:
        print_error("System Libraries", f"Unsupported OS: {system}. Exiting.")
        exit(1)

def install_nodejs_LTS():
    if not is_installed("node"):
        system = platform.system()
        if system == "Darwin":  # macOS
            install_package("Node.js LTS", "brew install node@lts")
        elif system == "Linux":  # Linux
            install_package(
                "Node.js Setup Script",
                "curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -"
            )
            install_package("Node.js LTS", "sudo apt-get install -y nodejs")
        else:
            print_error("Node.js LTS", f"Unsupported OS: {system}. Exiting.")
            exit(1)
    else:
        print_success("Node.js (already installed)")

def install_neovim_latest():
    if not is_installed("nvim"):
        system = platform.system()
        if system == "Darwin":  # macOS
            install_package("Neovim", "brew install --HEAD neovim")
        elif system == "Linux":  # Linux
            install_package("Neovim PPA", "sudo add-apt-repository ppa:neovim-ppa/unstable -y")
            install_package("Update APT", "sudo apt-get update -y")
            install_package("Neovim", "sudo apt-get install -y neovim")
        else:
            print_error("Neovim", f"Unsupported OS: {system}. Exiting.")
            exit(1)
    else:
        print_success("Neovim (already installed)")

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

    def download_file(url, path):
        try:
            print_starting(f"Downloading {url}")
            urllib.request.urlretrieve(url, path)
            print_success(f"Downloaded {url}")
        except Exception as e:
            print_error(f"Downloading {url}", str(e))
            exit(1)

    download_file(plug_vim_url, plug_vim_path)
    download_file(nvim_init_url, init_vim_path)
    download_file(vimrc_url, vimrc_path)

#########################
#      Install plgin    #
#########################
def install_nvim_plugins():
    """Install Neovim plugins using :PlugInstall."""
    try:
        print_starting("Neovim Plugins")
        subprocess.run(
            ["nvim", "+PlugInstall", "+qall"],
            check=True
        )
        print_success("Neovim Plugins installed successfully")
    except subprocess.CalledProcessError as e:
        print_error("Neovim Plugins", str(e))

#########################
#      Source sh        #
#########################

def source_shell_rc(shell_rc_path):
    """Source the shell configuration file."""
    try:
        if os.path.exists(shell_rc_path):
            print(f"Sourcing {shell_rc_path} to apply changes...")
            subprocess.run(f'source {shell_rc_path}', shell=True, executable='/bin/bash', check=True)
            print(f"Successfully sourced {shell_rc_path}")
        else:
            print(f"{shell_rc_path} does not exist. Skipping sourcing.")
    except subprocess.CalledProcessError as e:
        print(f"Failed to source {shell_rc_path}: {str(e)}")


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
    source_shell_rc(shell_rc)

def install_coc_languages():
    """
    Reads the ./coc/extensions/package.json file and installs all listed coc.nvim extensions.
    """
    try:
        # Path to the package.json file
        package_json_path = os.path.expanduser('./coc/extensions/package.json')

        # Check if the file exists
        if not os.path.exists(package_json_path):
            print(f"Error: {package_json_path} does not exist.")
            return

        # Read the package.json file
        with open(package_json_path, 'r') as file:
            data = json.load(file)

        # Extract dependencies
        extensions = data.get('dependencies', {})
        if not extensions:
            print("No extensions found in package.json.")
            return

        # Install each extension
        for extension in extensions.keys():
            print(f"Installing {extension}...")
            try:
                # Use the CocInstall command to install the extension
                subprocess.run(
                    ['nvim', '--headless', '-c', f'CocInstall {extension}', '-c', 'q'],
                    check=True
                )
                print(f"Successfully installed {extension}")
            except subprocess.CalledProcessError as e:
                print(f"Failed to install {extension}: {e}")
    except Exception as e:
        print(f"Error: {e}")



def install_treesitter_language():
    """
    Install treesiter language
    """
    try:
        languages = ["c", "cpp", "python", "java", "javascript", "typescript","cmake", "bash","dockerfile",]

        # Install each extension
        for language in languages:
            print(f"Installing {language}...")
            try:
                # Use the CocInstall command to install the extension
                subprocess.run(
                    ['nvim', '--headless', '-c', f'TSInstall {language}', '-c', 'q'],
                    check=True
                )
                print(f"Successfully installed {language}")
            except subprocess.CalledProcessError as e:
                print(f"Failed to install {language}: {e}")
    except Exception as e:
        print(f"Error: {e}")

def main():
    install_dependencies()
    download_files()
    install_nvim_plugins()
    install_coc_languages()
    install_treesitter_language()
    add_alias()

if __name__ == "__main__":
    main()
