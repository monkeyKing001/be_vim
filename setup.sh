#!/bin/bash

DIR="."
SETUP_PY="setup_vim.py"

chmod 777 ${DIR}/${SETUP_PY}
pip3 install -r requirements.txt

apt-get install sudo
