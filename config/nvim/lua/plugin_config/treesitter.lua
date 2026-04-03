--============================================================--
--               Treesitter Configuration (Lua)               --
--============================================================--

local status, configs = pcall(require, "nvim-treesitter.configs")
if not status then
    return
end

configs.setup({
  parser_install_dir = vim.fn.stdpath("data") .. "/site",
  ensure_installed = {
    "c", "cpp", "python", "lua", "json", "bash", "vim", "markdown",
    "java", "javascript", "typescript", "cmake", "dockerfile",
    "query", "vimdoc"
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
