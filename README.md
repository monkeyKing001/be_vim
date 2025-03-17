## **Automated Vim Setup**

Easily set up and configure Neovim with essential dependencies and tools.

---

### **Dependencies**
Before starting, ensure your system has:
- **Python 3**
- **pip for Python 3** (`python3-pip`)
- **venv** (`python3-venv`)
- **sudo**

If these dependencies are missing, the setup script(`setup.sh`) will install them for you.

---

### **How to Set Up**

1. **Run the Setup Script**  
	Open your terminal and execute:
   ```bash
   ./setup.sh
   ```

2. **Run the Setup Script**  
	Once the setup is complete, configure Neovim by running:
   ```bash
   source .venv/bin/activate
   python3 ./setup_vim.py
   ```

3. **Set an Alias for Neovim**  
   Replace `vim` with `nvim` for easier use:
   - **Linux (Bash)**:  
     After running the script, reload your shell configuration:
     ```bash
     source ~/.bashrc
     ```
   - **MacOS (Zsh)**:  
     Reload your shell configuration:
     ```bash
     source ~/.zshrc
     ```

### **Notes**
- This script handles the setup process for Neovim and ensures compatibility with your environment.
- If you encounter any issues, feel free to modify the script to suit your system.

## **자동화된 Vim 설정**

Neovim 자동 설정 스크립트.

---

### **의존성**
설치 전에 아래 도구가 시스템에 있어야 한다:
- **Python 3**
- **pip for Python 3** (`python3-pip`)
- **venv** (`python3-venv`)
- **sudo** 권한

위 의존성이 없다면, `setup.sh`스크립트가 자동으로 설치를 진행한다.

---

### **설정 방법**

1. **설치 스크립트 실행**  
   터미널에서 아래 명령어를 실행:
   ```bash
   ./setup.sh
   ```

2. **파이썬 스크립트 실행**  
   설치 완료 후, Neovim을 구성하려면 아래 명령어를 실행:
   ```bash
   source .venv/bin/activate
   python3 ./setup_vim.py
   ```

3. **Neovim 별칭 설정**  
   `vim` 명령어를 `nvim`으로 대체:
   - **Linux (Bash)**:  
     스크립트 실행 후, 셸 설정을 적용:
     ```bash
     source ~/.bashrc
     ```
   - **MacOS (Zsh)**:  
     스크립트 실행 후, 셸 설정을 적용:
     ```bash
     source ~/.zshrc
     ```

---

### **참고**
- 이 스크립트는 Neovim 설치 과정을 자동으로 처리하며, 환경에 맞는 호환성을 보장.
- 문제가 발생하면 스크립트를 수정하여 시스템에 맞게 조정.
