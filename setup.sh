#!/bin/bash

DIR="."
SETUP_PY="setup_vim.py"

# Make the Python script executable
chmod +x "${DIR}/${SETUP_PY}"

# Detect operating system
OS=$(uname -s)

# Install dependencies for Mac OS
if [[ "$OS" == "Darwin" ]]; then
    echo "Detected macOS. Using Homebrew for package installation."
    # Check if brew is installed
    if ! command -v brew &> /dev/null; then
        echo "Homebrew not found. Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    echo "Installing necessary packages using brew..."
    brew install python3 wget python3-pip python3-venv sudo clang llvm yarn nodejs npm

# Install dependencies for Linux
elif [[ "$OS" == "Linux" ]]; then
    echo "Detected Linux. Using apt-get for package installation."
    # Ensure apt-get is available
    if ! command -v apt-get &> /dev/null; then
        echo "apt-get not found. Please ensure you're using a compatible Linux distribution."
        exit 1
    fi
    echo "Installing necessary packages using apt-get..."
    apt-get update
    apt-get install -y python3 python3-pip python3-venv sudo wget clang clangd yarn nodejs npm
else
    echo "Unsupported operating system: $OS"
    exit 1
fi

# Install Python dependencies
#pip3 install -r requirements.txt
python3 -m venv .venv
source .venv/bin/activate
python3 -m pip install -r requirements.txt
chmod +x ./setup_vim.py

sudo npm install -g n
sudo n lts

echo "Setup completed successfully."
