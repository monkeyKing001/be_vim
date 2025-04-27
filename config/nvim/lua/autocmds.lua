--============================================================--
--                      Neovim Autocommands                    --
--============================================================--

-- API helpers
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Create a general group for user autocommands
local general_group = augroup("UserAutocmds", { clear = true })

-- [[ Template insertion on new files ]]
autocmd("BufNewFile", {
  group = general_group,
  pattern = "*.c",
  command = "0r ~/.vim/templates/skeleton.c",
})

autocmd("BufNewFile", {
  group = general_group,
  pattern = "*.cpp",
  command = "0r ~/.vim/templates/skeleton.cpp",
})

autocmd("BufNewFile", {
  group = general_group,
  pattern = "*.java",
  command = "0r ~/.vim/templates/skeleton.java",
})

autocmd("BufNewFile", {
  group = general_group,
  pattern = "Makefile",
  command = "0r ~/.vim/templates/skeleton_makefile",
})

autocmd("BufNewFile", {
  group = general_group,
  pattern = "README.md",
  command = "0r ~/.vim/templates/README.md",
})

-- [[ Auto-format C/C++ headers and sources on save ]]
autocmd("BufWritePre", {
  group = general_group,
  pattern = { "*.cpp", "*.h" },
  callback = function()
    vim.fn.CocAction("format")
  end,
})

-- 저장 시 자동 포맷
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.cpp", "*.h", "*.js", "*.ts", "*.py" },
  command = "silent! call CocAction('format')",
})
