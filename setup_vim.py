#!/usr/bin/env python3

import os
import shutil
import subprocess
import platform
import json
from termcolor import colored

def print_starting(package_name):
    print(colored(f"Starting installation of {package_name}...", "green"))

def print_success(package_name):
    print(colored(f"Successfully installed/synced {package_name}.", "green"))

def print_error(package_name, error_msg):
    print(colored(f"Failed to install/synced {package_name}: {error_msg}", "red"))

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
        dependencies = ["nvim", "curl", "git", "brew", "node"]
        for dep in dependencies:
            if not is_installed(dep):
                if dep == "brew":
                    install_package("Homebrew", '/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"')
                elif dep == "nvim":
                    # Install stable version of Neovim
                    install_package("Neovim", "brew install neovim")
                elif dep == "node":
                    install_package("Node.js", "brew install node")
                else:
                    install_package(dep, f"brew install {dep}")
    elif system == "Linux":
        print("Installing system libraries for Linux...")
        dependencies = ["sudo", "nvim", "curl", "git", "software-properties-common", "nodejs"]
        for dep in dependencies:
            if not is_installed(dep):
                if dep == "nvim":
                    install_package("Neovim PPA", "sudo add-apt-repository ppa:neovim-ppa/unstable -y")
                    install_package("Update APT", "sudo apt-get update -y")
                    install_package("Neovim", "sudo apt-get install -y neovim")
                elif dep == "nodejs":
                    install_package("Node.js Setup", "curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -")
                    install_package("Node.js", "sudo apt-get install -y nodejs")
                else:
                    install_package(dep, f"sudo apt-get install -y {dep}")
    else:
        print_error("System Libraries", f"Unsupported OS: {system}. Exiting.")
        exit(1)

def install_dependencies():
    install_system_lib()

#########################
#      Sync Config      #
#########################

def sync_config():
    """
    Sync local configuration files to the Neovim config directory.
    """
    home_dir = os.path.expanduser("~")
    nvim_config_dest = os.path.join(home_dir, ".config", "nvim")
    vimrc_dest = os.path.join(home_dir, ".vimrc")
    
    # Local source paths
    current_dir = os.path.dirname(os.path.abspath(__file__))
    nvim_config_src = os.path.join(current_dir, "config", "nvim")
    vimrc_src = os.path.join(current_dir, ".vimrc")

    # 1. Sync nvim config directory
    if os.path.exists(nvim_config_src):
        print_starting("Syncing Neovim configuration files")
        os.makedirs(os.path.dirname(nvim_config_dest), exist_ok=True)
        
        try:
            # For Python 3.8+, we can use dirs_exist_ok=True
            if os.path.exists(nvim_config_dest):
                shutil.copytree(nvim_config_src, nvim_config_dest, dirs_exist_ok=True)
            else:
                shutil.copytree(nvim_config_src, nvim_config_dest)
            print_success("Neovim configuration synced from local config/nvim")
        except Exception as e:
            print_error("Neovim configuration sync", str(e))

    # 2. Sync .vimrc file
    if os.path.exists(vimrc_src):
        print_starting("Syncing .vimrc")
        try:
            shutil.copy2(vimrc_src, vimrc_dest)
            print_success(".vimrc synced from local .vimrc")
        except Exception as e:
            print_error(".vimrc sync", str(e))

#########################
#      Install Plugins   #
#########################

def install_nvim_plugins():
    """Install Neovim plugins using lazy.nvim's headless sync."""
    try:
        print_starting("Neovim Plugins (lazy.nvim sync)")
        # Lazy! sync installs plugins. We add a small delay/wait if needed.
        subprocess.run(
            ["nvim", "--headless", "+Lazy! sync", "+qa"],
            check=True
        )
        print_success("Neovim Plugins synced")
    except subprocess.CalledProcessError as e:
        # Sometimes lazy sync returns non-zero even if mostly successful
        print(colored(f"  Note: Lazy sync finished with some notices (this is often okay).", "yellow"))

def install_coc_languages():
    """
    Reads the ./coc/extensions/package.json file and installs all listed coc.nvim extensions.
    """
    try:
        current_dir = os.path.dirname(os.path.abspath(__file__))
        package_json_path = os.path.join(current_dir, 'coc', 'extensions', 'package.json')

        if not os.path.exists(package_json_path):
            return

        with open(package_json_path, 'r') as file:
            data = json.load(file)

        extensions = data.get('dependencies', {})
        for extension in extensions.keys():
            print(f"Installing coc extension: {extension}...")
            # Use --headless and -c for each extension installation
            subprocess.run(
                ['nvim', '--headless', '-c', f'CocInstall -sync {extension}', '-c', 'q'],
                capture_output=True # Capture output to avoid messy logs
            )
        print_success("coc.nvim extensions synced")
    except Exception as e:
        print_error("coc.nvim extensions", str(e))

#########################
#   Generate Env Config #
#########################

def generate_env_config():
    """
    Generates ~/.config/nvim/lua/env_paths.lua with absolute paths
    to the project's Python virtual environment and the system's Node.js.
    """
    try:
        print_starting("Environment configuration (env_paths.lua)")
        
        home_dir = os.path.expanduser("~")
        lua_config_dir = os.path.join(home_dir, ".config", "nvim", "lua")
        env_paths_file = os.path.join(lua_config_dir, "env_paths.lua")
        
        # 1. Determine Python Path (Project .venv or System)
        current_dir = os.path.dirname(os.path.abspath(__file__))
        venv_python = os.path.join(current_dir, ".venv", "bin", "python3")
        
        if os.path.exists(venv_python):
            final_python = venv_python
            print(f"  Found project venv: {final_python}")
        else:
            final_python = shutil.which("python3")
            print(f"  Project venv not found. Using system python: {final_python}")

        # 2. Determine Node Path (System)
        final_node = shutil.which("node")
        if final_node:
             print(f"  Found node executable: {final_node}")
        else:
             final_node = ""
             print(colored("  Warning: Node.js executable not found in PATH.", "yellow"))

        # 3. Write Lua file
        os.makedirs(lua_config_dir, exist_ok=True)
        
        lua_content = f"""-- Auto-generated by setup_vim.py
return {{
    python_path = "{final_python}",
    node_path = "{final_node}"
}}
"""
        with open(env_paths_file, "w") as f:
            f.write(lua_content)
            
        print_success(f"Generated {env_paths_file}")

    except Exception as e:
        print_error("Environment configuration", str(e))

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
    
    try:
        with open(shell_rc, "a") as file:
            file.write(f"\n# Alias for Neovim\n{alias_command}\n")
        print(f"Added alias to {shell_rc}.")
    except Exception as e:
        print(f"Failed to add alias: {e}")

def main():
    install_dependencies()
    sync_config()
    generate_env_config()
    install_nvim_plugins()
    install_coc_languages()
    add_alias()

if __name__ == "__main__":
    main()
