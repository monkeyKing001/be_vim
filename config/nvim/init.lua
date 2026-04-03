

--============================================================--
--                       Neovim Init.lua                       --
--                (for Lua-based full configuration)           --
--============================================================--

-- [[ Fix Treesitter Runtimepath & Parser Dir ]]
-- Define the exact, absolute path once. No trailing slashes.
vim.g.treesitter_parser_dir = vim.fn.stdpath("data") .. "/site"

-- Force Neovim to look here FIRST for anything (including parsers)
vim.opt.runtimepath:prepend(vim.g.treesitter_parser_dir)

-- [[ Set leader key early ]]
vim.g.mapleader = ","
vim.g.maplocalleader = ","

--[[ Load Legacy vimrc config ]]
-- vim.cmd("source ~/.config/nvim/lua/legacy_config.vim") --

-- [[ Plugin manager bootstrap (lazy.nvim) ]]
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- [[ Load plugins ]]
require("plugins")         -- Plugin definitions (via lazy.nvim)

-- [[ Load core settings ]]
require("settings")        -- Vim options (e.g., number, tabstop, mouse...)
require("mappings")        -- Key mappings (normal, insert, visual...)

-- [[ Load auto cmd after plugins, coresettings ]]
require("autocmds")        -- Autocommands (e.g., templates, format on save)


-- [[ Load plugin configurations (Moved to lua/plugins.lua config blocks) ]]
-- require("plugin_config.treesitter")
-- require("plugin_config.coc")
-- require("plugin_config.airline")
-- require("plugin_config.ultisnips")
-- require("plugin_config.nerdtree")
-- require("plugin_config.cmp")
-- require("plugin_config.copilot")
-- require("plugin_config.imgclip")
-- require("plugin_config.telescope")
-- require("plugin_config.webdevicons")
-- Add more plugin configs as needed

-- [[ Dynamic Environment Paths ]]
-- setup_vim.py가 생성하는 env_paths.lua 파일을 로드 시도
local has_env, env_paths = pcall(require, "env_paths")

if has_env then
    vim.g.python3_host_prog = env_paths.python_path
    vim.g.coc_node_path = env_paths.node_path
else
    -- Fallback: env_paths.lua가 없을 경우 시스템 경로 사용
    vim.g.python3_host_prog = vim.fn.exepath("python3")
    vim.g.coc_node_path = vim.fn.exepath("node")
end

-- [[ Colorscheme ]]
vim.cmd.colorscheme("koehler")

-- [[ UI tweaks for terminal compatibility ]]
if vim.fn.has("termguicolors") == 1 then
  vim.opt.termguicolors = true
end

-- [[ Fix 256-color tmux BCE issue ]]
--if vim.env.TERM:find("256color") then
--  vim.opt.t_ut = ""
--end

-- [[ Final statusline behavior ]]
vim.opt.laststatus = 2

