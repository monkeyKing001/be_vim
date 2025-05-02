

--============================================================--
--                       Neovim Init.lua                       --
--                (for Lua-based full configuration)           --
--============================================================--

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


-- [[ Load plugin configurations ]]
require("plugin_config.treesitter")
require("plugin_config.coc")
require("plugin_config.airline")
require("plugin_config.ultisnips")
require("plugin_config.nerdtree")
--require("plugin_config.dadbod")
--require("plugin_config.restconsole")
--require("plugin_config.go")
require("plugin_config.cmp")
--require("plugin_config.avante")
require("plugin_config.copilot")
require("plugin_config.imgclip")
require("plugin_config.telescope")
require("plugin_config.webdevicons")
-- Add more plugin configs as needed

-- [[ Python virtualenv path for Python 3 provider ]]
vim.g.python3_host_prog = "~/be_vim/.venv/bin/python3"

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

