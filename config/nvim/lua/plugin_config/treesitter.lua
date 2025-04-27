--============================================================--
--               Treesitter Configuration (Lua)               --
--============================================================--

-- plugin_config/treesitter.lua

require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "c", "cpp", "python", "lua", "json", "bash", "vim", "markdown",
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
  },
  autotag = {
    enable = true,
  },
})

