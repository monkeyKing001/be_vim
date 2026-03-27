#!/usr/bin/env python3

import os
import shutil
import subprocess
import platform
from datetime import datetime
from pathlib import Path

try:
    from termcolor import colored
except ImportError:
    def colored(text, color=None, attrs=None): return text

# --- Utility Functions ---

def print_step(msg):
    print(colored(f"\n[+] {msg}", "cyan", attrs=["bold"]))

def print_success(msg):
    print(colored(f"  ✓ {msg}", "green"))

def print_error(msg):
    print(colored(f"  ✗ {msg}", "red"))

def run_cmd(cmd, cwd=None, capture=False):
    """Run a shell command safely."""
    try:
        res = subprocess.run(
            cmd, shell=isinstance(cmd, str), check=True,
            capture_output=capture, text=True, cwd=cwd
        )
        return True, res.stdout if capture else ""
    except subprocess.CalledProcessError as e:
        return False, e.stderr if capture else str(e)

# --- Backup/Sync Operations ---

def sync_files_to_repo(base_dir: Path, home_dir: Path):
    """Copy active configurations back into the repository."""
    print_step("Syncing active configurations to repository")
    
    # 1. Neovim config directory
    nvim_src = home_dir / ".config" / "nvim"
    nvim_dest = base_dir / "config" / "nvim"
    if nvim_src.exists():
        try:
            if nvim_dest.exists():
                shutil.rmtree(nvim_dest)
            shutil.copytree(nvim_src, nvim_dest, ignore=shutil.ignore_patterns(".git", "__pycache__", "lazy-lock.json"))
            print_success("Copied ~/.config/nvim to config/nvim")
        except Exception as e:
            print_error(f"Failed to copy config/nvim: {e}")


    # 2. coc package.json
    coc_pkg_src = home_dir / ".config" / "coc" / "extensions" / "package.json"
    coc_pkg_dest = base_dir / "coc" / "extensions" / "package.json"
    if coc_pkg_src.exists():
        try:
            coc_pkg_dest.parent.mkdir(parents=True, exist_ok=True)
            shutil.copy2(coc_pkg_src, coc_pkg_dest)
            print_success("Copied coc package.json")
        except Exception as e:
            print_error(f"Failed to copy coc package.json: {e}")

# --- Git Operations ---

def commit_and_push(base_dir: Path):
    """Create a new branch, commit changes, and push to remote."""
    print_step("Handling Git Operations")

    # Check if there are any changes
    success, status_out = run_cmd(["git", "status", "--porcelain"], cwd=str(base_dir), capture=True)
    if not status_out.strip():
        print_success("No configuration changes found. Everything is up to date!")
        return

    date_str = datetime.now().strftime("%Y%m%d_%H%M%S")
    hostname = platform.node()
    branch_name = f"update/{date_str}_{hostname}"

    print(colored(f"  Changes detected. Creating branch: {branch_name}", "yellow"))

    # 1. Create and checkout new branch
    success, err = run_cmd(["git", "checkout", "-b", branch_name], cwd=str(base_dir), capture=True)
    if not success:
        print_error(f"Failed to create branch: {err}")
        return
    print_success("Created new branch")

    # 2. Add all changes
    success, err = run_cmd(["git", "add", "."], cwd=str(base_dir), capture=True)
    if not success:
        print_error(f"Failed to stage changes: {err}")
        return
    print_success("Staged files")

    # 3. Commit
    commit_msg = f"chore: auto-update config from {hostname} on {date_str}"
    success, err = run_cmd(["git", "commit", "-m", commit_msg], cwd=str(base_dir), capture=True)
    if not success:
        print_error(f"Failed to commit changes: {err}")
        return
    print_success("Committed changes")

    # 4. Push to remote
    print(colored("  Pushing to remote repository...", "yellow"))
    success, err = run_cmd(["git", "push", "--set-upstream", "origin", branch_name], cwd=str(base_dir), capture=True)
    if success:
        print_success(f"Successfully pushed branch '{branch_name}' to remote!")
    else:
        print_error(f"Failed to push to remote: {err}")
        print(colored("  Note: You might need to authenticate with Git/GitHub if you haven't already.", "yellow", attrs=["bold"]))

# --- Main Flow ---

def main():
    base_dir = Path(__file__).parent.resolve()
    home_dir = Path.home()
    
    print(colored("Starting Configuration Backup (Sync to Repo)", "cyan", attrs=["bold", "reverse"]))
    
    sync_files_to_repo(base_dir, home_dir)
    commit_and_push(base_dir)
    
    print_step("Update Process Completed! 🚀")

if __name__ == "__main__":
    main()
