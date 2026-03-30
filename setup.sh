#!/bin/bash
set -e

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$DIR"

echo "==== Starting Neovim Setup Bootstrap (v2) ===="

OS=$(uname -s)

install_mac_deps() {
    echo "Detected macOS. Checking Homebrew..."
    if ! command -v brew &> /dev/null; then
        echo "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    echo "Updating Homebrew and installing dependencies..."
    brew update
    brew install neovim curl git python3 wget node yarn
}

install_linux_deps() {
    echo "Detected Linux. Checking apt-get..."
    if ! command -v apt-get &> /dev/null; then
        echo "apt-get not found. This script requires a Debian/Ubuntu-based system."
        exit 1
    fi
    echo "Installing necessary packages using apt-get..."
    sudo apt-get update
    sudo apt-get install -y software-properties-common python3 python3-pip python3-venv sudo wget curl git clang clangd yarn nodejs npm

    if ! command -v nvim &> /dev/null; then
        echo "Installing Neovim from unstable PPA..."
        sudo add-apt-repository ppa:neovim-ppa/unstable -y
        sudo apt-get update -y
        sudo apt-get install -y neovim
    fi
}

# 1. OS-specific dependencies
if [[ "$OS" == "Darwin" ]]; then
    install_mac_deps
elif [[ "$OS" == "Linux" ]]; then
    install_linux_deps
else
    echo "Unsupported OS: $OS"
    exit 1
fi

# 2. Node.js setup (using 'n')
if [[ "$OS" == "Linux" ]]; then
    echo "Setting up Node.js LTS globally..."
    sudo npm install -g n || true
    sudo n lts || true
fi

# 3. Virtual environment and Python dependencies
echo "Setting up Python virtual environment..."
if [ ! -d ".venv" ]; then
    python3 -m venv .venv
fi
source .venv/bin/activate
pip install --upgrade pip
if [ -f "requirements.txt" ]; then
    pip install -r requirements.txt
fi

# 4. Run Python Setup
echo "Running Neovim configuration script (setup_vim.py)..."
chmod +x setup_vim.py
python3 setup_vim.py

echo "==== Bootstrap Completed Successfully ===="
