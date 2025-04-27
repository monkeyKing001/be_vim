--============================================================--
--                        Neovim Settings                      --
--============================================================--

-- UI
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.showmatch = true
vim.opt.colorcolumn = "80"
vim.opt.laststatus = 2
vim.opt.mouse = "a"
vim.opt.termguicolors = true

-- Indentation
vim.opt.autoindent = true
vim.opt.cindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Search
vim.opt.hlsearch = true
vim.opt.wildmenu = true

-- Encoding for wed devi cons
vim.opt.fileencoding = "utf-8"
vim.opt.fileencodings = { "utf-8", "euc-kr", "iso-2022-kr" } -- 한국어 환경이라면 추가


-- Clipboard
vim.opt.clipboard:append("unnamedplus")

-- Filetype
vim.cmd("filetype plugin indent on")
vim.cmd("syntax on")

-- Window management
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Timeout for mapped sequences
vim.opt.timeout = true
vim.opt.ttimeout = true
vim.opt.ttimeoutlen = 10

-- Airline-specific fallback if needed
vim.g.airline_theme = "badwolf"
vim.g["airline#extensions#tabline#enabled"] = 1
vim.g["airline#extensions#tabline#fnamemod"] = ":t"

-- Set shell if needed (optional)
-- vim.opt.shell = "/bin/bash"

