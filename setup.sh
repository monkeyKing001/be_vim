#!/bin/bash

DIR="."
SETUP_PY="setup_vim.py"

# Make the Python script executable
chmod 777 ${DIR}/${SETUP_PY}

# Detect operating system
OS=$(uname -s)

if [[ "$OS" == "Darwin" ]]; then
    echo "Detected macOS. Using Homebrew for package installation."
    # Check if brew is installed
    if ! command -v brew &> /dev/null; then
        echo "Homebrew not found. Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    echo "Installing necessary packages using brew..."
    brew install python3 python3-pip sudo
elif [[ "$OS" == "Linux" ]]; then
    echo "Detected Linux. Using apt-get for package installation."
    # Ensure apt-get is available
    if ! command -v apt-get &> /dev/null; then
        echo "apt-get not found. Please ensure you're using a compatible Linux distribution."
        exit 1
    fi
    echo "Installing necessary packages using apt-get..."
#    sudo apt-get update
#    sudo apt-get install -y python3, pip
    apt-get update
    apt-get install -y python3 python3-pip sudo
else
    echo "Unsupported operating system: $OS"
    exit 1
fi

# Install Python dependencies
pip3 install -r requirements.txt
chmod +x ./setup_vim.py

echo "Setup completed successfully."
